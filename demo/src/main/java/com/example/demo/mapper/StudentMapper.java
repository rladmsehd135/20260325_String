package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Stu;


@Mapper
public interface StudentMapper {
	public List<Stu> selectStuList(HashMap<String, Object> map);
	public Stu selectStuNo(HashMap<String,Object> map);
	public int deleteStudent(HashMap<String, Object> map);
	public int insertStu(HashMap<String,Object> map);
}
