package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Emp;
import com.example.demo.model.Student;

@Mapper
public interface EmpMapper {
	// 여러개 리턴 -> selectXXXList
	public List<Emp> selectEmpList(HashMap<String, Object> map);
	public int insertEmp(HashMap<String, Object> map);
	public Emp selectEmp(HashMap<String, Object> map);
	public int deleteEmp(HashMap<String, Object> map);
	
	public int selectEmpCount(HashMap<String, Object> map);
}


