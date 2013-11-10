package com.jivesoftware.openfire.plugin;

import java.io.File;

import org.eclipse.jetty.util.log.Log;
import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.container.Plugin;
import org.jivesoftware.openfire.container.PluginManager;
import org.jivesoftware.openfire.interceptor.InterceptorManager;
import org.jivesoftware.openfire.interceptor.PacketInterceptor;
import org.jivesoftware.openfire.interceptor.PacketRejectedException;
import org.jivesoftware.openfire.session.Session;
import org.xmpp.packet.Packet;

import com.jivesoftware.openfire.Interceptor.PressureInterceptor;

public class PressurePlugin implements Plugin {

	private XMPPServer server;
	private InterceptorManager interceptorManager;

	public PressurePlugin() {
		server = XMPPServer.getInstance();
		interceptorManager = InterceptorManager.getInstance();
	}

	public void initializePlugin(PluginManager manager, File pluginDirectory) {
		// TODO Auto-generated method stub
		PressureInterceptor pressureInterceptor = new PressureInterceptor();
		interceptorManager.addInterceptor(pressureInterceptor);
		System.out.println("初始化…… 安装插件！");
		System.out.println(server.getServerInfo());
		Log.info("初始化…… 安装插件！");
	}

	public void destroyPlugin() {
		// TODO Auto-generated method stub
		System.out.println("服务器停止，销毁插件！");
	}



}
