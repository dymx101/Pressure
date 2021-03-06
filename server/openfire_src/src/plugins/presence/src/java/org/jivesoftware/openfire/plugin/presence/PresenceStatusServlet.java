/**
 * $RCSfile$
 * $Revision: 1710 $
 * $Date: 2005-07-26 15:56:14 -0300 (Tue, 26 Jul 2005) $
 *
 * Copyright (C) 2004-2008 Jive Software. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.jivesoftware.openfire.plugin.presence;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jivesoftware.admin.AuthCheckFilter;
import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.plugin.PresencePlugin;
import org.jivesoftware.openfire.user.UserNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xmpp.packet.JID;
import org.xmpp.packet.Presence;

/**
 * Servlet that provides information about the presence status of the users in
 * the system. The information may be provided in XML format or in graphical
 * mode. Use the <b>type</b> parameter to specify the type of information to
 * get. Possible values are <b>image</b> and <b>xml</b>. If no type was defined
 * then an image representation is assumed.
 * <p>
 * <p/>
 * The request <b>MUST</b> include the <b>jid</b> parameter. This parameter will
 * be used to locate the local user in the server. If this parameter is missing
 * from the request then an error will be logged and nothing will be returned.
 * 
 * @author Gaston Dombiak
 */
public class PresenceStatusServlet extends HttpServlet {

	private static final Logger Log = LoggerFactory
			.getLogger(PresenceStatusServlet.class);

	private PresencePlugin plugin;
	private XMLPresenceProvider xmlProvider;
	private JsonPresenceProvider jsonProvider;

	byte available[];
	byte away[];
	byte chat[];
	byte dnd[];
	byte offline[];
	byte xa[];

	@Override
	public void init(ServletConfig servletConfig) throws ServletException {
		super.init(servletConfig);
		plugin = (PresencePlugin) XMPPServer.getInstance().getPluginManager()
				.getPlugin("presence");
		xmlProvider = new XMLPresenceProvider();
		jsonProvider = new JsonPresenceProvider();
		available = loadResource("/images/user-green-16x16.gif");
		away = loadResource("/images/user-yellow-16x16.gif");
		chat = loadResource("/images/user-green-16x16.gif");
		dnd = loadResource("/images/user-red-16x16.gif");
		offline = loadResource("/images/user-clear-16x16.gif");
		xa = loadResource("/images/user-yellow-16x16.gif");
		// Exclude this servlet from requering the user to login
		AuthCheckFilter.addExclude("presence/status");
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String secureKey = request.getParameter("secure_key");
		String sender = request.getParameter("req_jid");
		String jid = request.getParameter("jid");
		String jids = request.getParameter("jids");
		String type = "json";
		if (secureKey == null || !secureKey.equals("EASON_KEY_KEY_KEY_KEY")) {
			return;
		}
		if (jids != null) {
			try {
				String[] jidList = jids.split(",");
				List<Presence> presences = new ArrayList<Presence>(
						jidList.length);
				for (String jidStr : jidList) {
					Presence presence = null;
					try {
						presence = plugin.getPresence(sender, jidStr);
					} catch (UserNotFoundException e) {
						continue;
					}
					if (presence != null) {
						presences.add(presence);
					} else {
						presence = new Presence();
						presence.setFrom(new JID(jidStr));
						presences.add(presence);
					}
				}
				if ("xml".equals(type)) {
					xmlProvider.sendInfo(request, response, presences);
				} else if ("json".equals(type)) {
					jsonProvider.sendInfo(request, response, presences);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			try {

				Presence presence = plugin.getPresence(sender, jid);
				if ("xml".equals(type)) {
					xmlProvider.sendInfo(request, response, presence);
				} else if ("json".equals(type)) {
					jsonProvider.sendInfo(request, response, presence);
				} else {
					Log.warn("The presence servlet received an invalid request of type: "
							+ type);
					// TODO Do something
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void destroy() {
		super.destroy();
		available = null;
		away = null;
		chat = null;
		dnd = null;
		offline = null;
		xa = null;
		// Release the excluded URL
		AuthCheckFilter.removeExclude("presence/status");
	}

	private byte[] loadResource(String path) {
		ServletContext context = getServletContext();
		InputStream in = context.getResourceAsStream(path);
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		try {
			for (int i = in.read(); i > -1; i = in.read()) {
				out.write(i);
			}
		} catch (IOException e) {
			Log.error("error loading:" + path);
		}
		return out.toByteArray();
	}

}
