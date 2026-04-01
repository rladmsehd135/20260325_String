package com.example.demo.model;

import lombok.Data;

@Data
public class User {
	String userId;
	String userName;
	String pwd;
	String gender;
	
	//첨부파일
	int fileNo;
	String filePath;
	String fileName;
	String fileOrgName;
	String fileSize;
	String fileETC;
}