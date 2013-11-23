package org.jivesoftware.openfire.plugin.presence;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.user.User;
import org.jivesoftware.util.JiveGlobals;

import org.xmpp.packet.JID;
import org.xmpp.packet.PacketError;
import org.xmpp.packet.Presence;

public class JsonPresenceProvider extends PresenceInfoProvider {

	@Override
	public void sendInfo(HttpServletRequest request,
			HttpServletResponse response, Presence presence) throws IOException {
		response.setContentType("text/json");
		PrintWriter out = response.getWriter();
		try {
			JSONObject presenceObject = new JSONObject();
			JSONObject jsonObject = new JSONObject();

			if (presence == null) {
				JID targetJID = new JID(request.getParameter("jid"));
				jsonObject.put("jid", targetJID.toBareJID());
				XMPPServer server = XMPPServer.getInstance();
				User user = server.getUserManager()
						.getUser(targetJID.getNode());
				String status = server.getPresenceManager()
						.getLastPresenceStatus(user);
				if (status != null) {
					jsonObject.put("status", status);
				} else {
					jsonObject.put("status", JiveGlobals
							.getProperty("plugin.presence.unavailable.status",
									"Unavailable"));
				}
			} else {
				jsonObject.put("jid", request.getParameter("jid"));
				jsonObject.put("status", presence.getStatus());
			}
			presenceObject.put("presence", jsonObject);
			out.println(presenceObject.toString());
			out.flush();
		} catch (Exception e) {
		}
	}

	@Override
	public void sendInfo(HttpServletRequest request,
			HttpServletResponse response, List<Presence> presences)
			throws IOException {
		response.setContentType("text/json");
		PrintWriter out = response.getWriter();
		try {
			JSONArray array = new JSONArray();
			for (Presence presence : presences) {
				JSONObject presenceObject = new JSONObject();
				JSONObject jsonObject = new JSONObject();
				if (presence.getStatus() == null) {

					JID targetJID = new JID(presence.getFrom().toBareJID());
					jsonObject.put("jid", targetJID.toBareJID());
					XMPPServer server = XMPPServer.getInstance();
					User user = server.getUserManager().getUser(
							targetJID.getNode());
					String status = server.getPresenceManager()
							.getLastPresenceStatus(user);
					if (status != null) {
						jsonObject.put("status", status);
					} else {
						jsonObject.put("status", JiveGlobals.getProperty(
								"plugin.presence.unavailable.status",
								"Unavailable"));
					}
				} else {
					jsonObject.put("jid", presence.getFrom().toBareJID());
					jsonObject.put("status", presence.getStatus());
				}
				presenceObject.put("presence", jsonObject);
				array.add(presenceObject);
			}
			out.println(array.toString());
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void sendUserNotFound(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/json");
		PrintWriter out = response.getWriter();
		// Send a forbidden presence
		Presence presence = new Presence();
		presence.setError(PacketError.Condition.forbidden);
		try {
			presence.setFrom(new JID(request.getParameter("jid")));
		} catch (Exception e) {
		}
		try {
			presence.setTo(new JID(request.getParameter("req_jid")));
		} catch (Exception e) {
		}
		out.println(presence.toXML());
		out.flush();
	}
}
