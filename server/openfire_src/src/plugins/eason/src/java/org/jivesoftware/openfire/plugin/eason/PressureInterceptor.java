package org.jivesoftware.openfire.plugin.eason;

import org.jivesoftware.openfire.interceptor.PacketInterceptor;
import org.jivesoftware.openfire.interceptor.PacketRejectedException;
import org.jivesoftware.openfire.session.Session;
import org.xmpp.packet.IQ;
import org.xmpp.packet.Message;
import org.xmpp.packet.Packet;
import org.xmpp.packet.Presence;

public class PressureInterceptor implements PacketInterceptor {

	private PressureSender sender = PressureSender.getInstance();

	public void interceptPacket(Packet packet, Session session,
			boolean incoming, boolean processed) throws PacketRejectedException {

		if (incoming) {
			if (!processed && (packet instanceof Message)) {

			}
			if (!processed && (packet instanceof Presence)) {
//				Presence presence = (Presence) packet;
//				if (presence.getType() == Type.unavailable) {
//					sender.sendUserOnlineStatus(presence.getFrom().toBareJID(),
//							0);
//				}

//				System.err.println(packet.toXML());
//				System.out.println(presence.getType().toString());
			}
			if (!processed && (packet instanceof IQ)) {

			}

		}
	}

}
