package com.pressure.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.pressure.service.ProfileService;

@Controller("apiXmppcontroller")
public class ApiXmppController extends AbstractBaseController {

	@Resource
	private ProfileService profileService;

}
