package com.jivesoftware.openfire.Interceptor;

import org.eclipse.jetty.util.log.Log;
import org.jivesoftware.openfire.interceptor.PacketInterceptor;
import org.jivesoftware.openfire.interceptor.PacketRejectedException;
import org.jivesoftware.openfire.session.Session;
import org.xmpp.packet.Packet;

public class PressureInterceptor implements PacketInterceptor {

	public void interceptPacket(Packet packet, Session session,
			boolean incoming, boolean processed) throws PacketRejectedException {
		// TODO Auto-generated method stub

		Log.info("my packet" + packet.toXML());
	}

}
