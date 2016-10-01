package model;
import java.io.Serializable;
import java.util.Date;

public class Note implements Serializable
{
	private int id;
	private User author;
	private Date pubiishDate;
	private String noteURI;
	private Boolean isPrivate;
	
	public User getAuthor()
	{
		return author;
	}
	public void setAuthor(User author)
	{
		this.author = author;
	}
	public Date getPubiishDate()
	{
		return pubiishDate;
	}
	public void setPubiishDate(Date pubiishDate)
	{
		this.pubiishDate = pubiishDate;
	}
	public String getNoteURI()
	{
		return noteURI;
	}
	public void setNoteURI(String noteURI)
	{
		this.noteURI = noteURI;
	}
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public Boolean getPrivate()
	{
		return isPrivate;
	}
	public void setPrivate(Boolean aPrivate)
	{
		isPrivate = aPrivate;
	}
}
