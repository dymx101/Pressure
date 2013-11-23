package org.jivesoftware.openfire.plugin.eason;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jivesoftware.admin.AuthCheckFilter;
import org.jivesoftware.openfire.XMPPServer;
import org.jivesoftware.openfire.plugin.PressurePlugin;

public class PressureServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private PressurePlugin plugin;

	@Override
	public void init(ServletConfig servletConfig) throws ServletException {
		super.init(servletConfig);
		plugin = (PressurePlugin) XMPPServer.getInstance().getPluginManager()
				.getPlugin("eason");

		AuthCheckFilter.addExclude("eason/pressure");
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String secureKey = request.getParameter("secure_key");
		String actionType = request.getParameter("action_type");
		String fromJid = request.getParameter("from_jid");
		String toJid = request.getParameter("to_jid");
		if (secureKey == null || !secureKey.equals("EASON_KEY_KEY_KEY_KEY")) {
			return;
		}
		if (actionType.equals("talker_find_father")) {
			plugin.talkerFindFather(fromJid, toJid);
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
		// Release the excluded URL
		AuthCheckFilter.removeExclude("eason/pressure");
	}
}
