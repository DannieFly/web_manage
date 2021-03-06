package dao;
import model.Log;
import model.Paper;

import java.io.*;
import java.sql.*;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedList;

public class PaperDao
{
	private Statement stmt;
	private Connection conn;
	
	private Statement newDao()
	{
		if (stmt != null)
			return stmt;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/papermanage?useSSL=false", "root", "coding");
			stmt = conn.createStatement();
			return stmt;
		}
		catch (SQLException e)
		{
			System.err.println("MySQL连接错误@dao.Dao");
			e.printStackTrace();
			return null;
		}
		catch (Exception e)
		{
			System.err.println("MySQL驱动程序错误@dao.Dao");
			e.printStackTrace();
			return null;
		}
	}

	private Connection newDao2()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/papermanage", "root", "coding");
			return conn;
		}
		catch (SQLException e)
		{
			System.err.println("MySQL连接错误@dao.Dao");
			e.printStackTrace();
			return null;
		}
		catch (Exception e)
		{
			System.err.println("MySQL驱动程序错误@dao.Dao");
			e.printStackTrace();
			return null;
		}
	}

	private int closeDao()
	{
		try
		{
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
			stmt = null;
			conn = null;
			return 1;
		}
		catch (SQLException e)
		{
			System.err.println("MySQL连接错误@dao.Dao.closeDao");
			e.printStackTrace();
			return -1;
		}
		catch (Exception e)
		{
			System.err.println("MySQL驱动程序错误@dao.Dao.closeDao");
			e.printStackTrace();
			return -2;
		}
	}
	
	public Collection<Paper> getAllPapers()
	{
		Collection<Paper> papers = new LinkedList<>();
		String sql = "SELECT * FROM paper;";
		stmt = newDao();
		ResultSet rs = null;
		try
		{
			rs = stmt.executeQuery(sql);
			Paper paper;
			while (rs.next())
			{
				paper = new Paper();
				paper.setId(rs.getInt("id"));
				paper.setTitle(rs.getString("title"));
				paper.setPublishDate(rs.getDate("publishDate"));
				Collection<String> author = new LinkedList<>();
				String authors = rs.getString("author");
				Collections.addAll(author, authors.split(";"));
				paper.setAuthors(author);
				paper.setAbstct(rs.getString("abstct"));
				paper.setFileURI(rs.getString("fileURI"));
				Collection<String> keyword = new LinkedList<>();
				String keywords = rs.getString("keyword");
				Collections.addAll(keyword, keywords.split(";"));
				paper.setKeywords(keyword);
				papers.add(paper);
			}
		}
		catch (SQLException e)
		{
			System.err.println("MySQL查询错误@dao.PaperDao.getAllPapers");
			e.printStackTrace();
			return null;
		}
		finally
		{
			if (rs != null)
				try
				{
					rs.close();
				}
				catch (SQLException e)
				{
					e.printStackTrace();
				}
			closeDao();
		}
		return papers;
	}
	
	public Paper getPaperById(int id)
	{
		String sql = "select * from paper where id='" + id + "';";
		stmt = newDao();
		ResultSet rs = null;
		try
		{
			rs = stmt.executeQuery(sql);
			Paper paper = new Paper();
			if (rs.next())
			{
				paper.setId(rs.getInt("id"));
				paper.setTitle(rs.getString("title"));
				paper.setPublishDate(rs.getDate("publishDate"));
				Collection<String> author = new LinkedList<>();
				String authors = rs.getString("author");
				for (String s : authors.split(";"))
				{
					author.add(s);
				}
				paper.setAuthors(author);
				paper.setAbstct(rs.getString("abstct"));
				paper.setFileURI(rs.getString("fileURI"));
				Collection<String> keyword = new LinkedList<>();
				String keywords = rs.getString("keyword");
				for (String s : keywords.split(";"))
				{
					keyword.add(s);
				}
				paper.setKeywords(keyword);
			}
			return paper;
		}
		catch (SQLException e)
		{
			System.err.println("MySQL查询错误@dao.PaperDao.getPaperById");
			e.printStackTrace();
			return null;
		}
		finally
		{
			if (rs != null)
				try
				{
					rs.close();
				}
				catch (SQLException e)
				{
					e.printStackTrace();
				}
			closeDao();
		}
	}

	public int insertNewPaper(String title, String fileURI, Date publishDate,
	                          Collection<String> authors, String abstct,
	                          Collection<String> keywords,java.io.File sourceFile, int operater)
	{
		String author = "",keyword = "";
		for (String s : authors) {
			author+=s;
			author+=';';
		}
		for (String s : keywords) {
			keyword+=s;
			keyword+=';';
		}

		final String INSERT_SQL = "insert into paper(title,fileURI,publishDate,author," +
				"abstct,keyword) values(?,?,?,?,?,?)";
		final String INSERT_SQL2 = "insert into paper(title,fileURI,publishDate,author," +
				"abstct,keyword,resource) values(?,?,?,?,?,?,?)";
		try
		{
			PreparedStatement ps;
			if (sourceFile==null)
				ps = newDao2().prepareStatement(INSERT_SQL,Statement.RETURN_GENERATED_KEYS);
			else
				ps = newDao2().prepareStatement(INSERT_SQL2,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, title);
			ps.setString(2, fileURI);
			ps.setDate(3, publishDate);
			ps.setString(4, author);
			ps.setString(5,abstct);
			ps.setString(6,keyword);
			if (sourceFile!=null) {
				if (sourceFile.exists())
					ps.setBinaryStream(7, new FileInputStream(sourceFile), (int) sourceFile.length());
			}
			int result = ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			int id;
			if (rs.next())
			{
				id = rs.getInt(1);
				LogDao logDao = new LogDao();
				if (logDao.insertLog(Log.ADD, Log.PAPER, id, operater) > 0)
					return result;
				else
					return -3;//写入日志失败
			}
			rs.close();
			return -2;//其他未知错误
		}
		catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return -4;
		} finally {
			closeDao();
		}
	}

	public InputStream getPaperBSbyid(int paper_id){
		String sql="Select resource from paper where id="+paper_id+";";
		stmt=newDao();
		ResultSet rs=null;
		try {
			rs=stmt.executeQuery(sql);
			if (rs.next()){
				return rs.getBinaryStream(1);
			}
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			closeDao();
		}
	}
	public int updatePaper(int id, String title, Collection<String> authors, String fileURI, Collection<String> keywords, String abstct, Date publishDate,java.io.File sourceFile, int uid)
	{
		String author = "", keyword = "";
		for (String s : authors)
			author = author.concat(s).concat(";");
		for (String s : keywords)
			keyword = keyword.concat(s).concat(";");
		final String UPDATE_SQL = "update paper SET title=? , publishDate=? ,author=? ," +
				"abstct=? ,keyword=?  where id=?";
		final String UPDATE_SQL2 = "update paper SET title=? , publishDate=? ,author=? ," +
				"abstct=? ,keyword=? , resource=? , fileURI=? where id=?";
		try
		{
			PreparedStatement ps;
			if (sourceFile==null)
				ps = newDao2().prepareStatement(UPDATE_SQL,Statement.RETURN_GENERATED_KEYS);
			else
				ps = newDao2().prepareStatement(UPDATE_SQL2,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, title);
			ps.setString(2, fileURI);
			ps.setDate(2, publishDate);
			ps.setString(3, author);
			ps.setString(4,abstct);
			ps.setString(5,keyword);
			if (sourceFile!=null) {
				if (sourceFile.exists())
				{
					ps.setString(7, fileURI);
					ps.setBinaryStream(6, new FileInputStream(sourceFile), (int) sourceFile.length());
				}
				ps.setInt(8,id);
			}
			else
				ps.setInt(6,id);
			int result = ps.executeUpdate();
			if(result>0)
			{
				LogDao logDao = new LogDao();
				if (logDao.insertLog(Log.EDIT, Log.PAPER, id, uid) > 0)
					return result;
				else
					return -3;//写入日志失败
			}
			return result;//其他未知错误
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return -1;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return -4;
		} finally {
			closeDao();
		}
	}
}
