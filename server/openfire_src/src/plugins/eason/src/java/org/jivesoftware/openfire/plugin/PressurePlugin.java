package org.jivesoftware.openfire.plugin;

import java.io.File;

import org.eclipse.jetty.util.log.Log;
import org.jivesoftware.openfire.PresenceRouter;
import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.container.Plugin;
import org.jivesoftware.openfire.container.PluginManager;
import org.jivesoftware.openfire.interceptor.InterceptorManager;
import org.jivesoftware.smack.packet.Presence.Type;
import org.json.XML;
import org.xmpp.packet.Presence;


public class PressurePlugin implements Plugin {

	private XMPPServer server;
	private InterceptorManager interceptorManager;
	private PresenceRouter presenceRouter;

	public PressurePlugin() {
		server = XMPPServer.getInstance();
		interceptorManager = InterceptorManager.getInstance();
		presenceRouter = server.getPresenceRouter();
	}

	public void initializePlugin(PluginManager manager, File pluginDirectory) {
		// TODO Auto-generated method stub
		//PressureInterceptor pressureInterceptor = new PressureInterceptor();
		//interceptorManager.addInterceptor(pressureInterceptor);
		System.out.println("初始化…… 安装插件！");
		System.out.println(server.getServerInfo());
		Log.info("初始化…… 安装插件！");
	}

	public void destroyPlugin() {
		// TODO Auto-generated method stub
		System.out.println("服务器停止，销毁插件！");
	}

	/**
	 * 倾诉者找到神父
	 * 
	 * @param fromJid
	 * @param toJid
	 */
	public void talkerFindFather(String fromJid, String toJid) {
		if (fromJid.equals(toJid)) {
			return;
		}
		
		Presence presence = new Presence();
		presence.setFrom(fromJid);
		presence.setTo(toJid);
		presence.setStatus("talker_find_father");
		presenceRouter.route(presence);
	}

}
