package web.action;

import com.opensymphony.xwork2.ActionSupport;
import model.Note;
import service.Service;

import java.util.Collection;
public class ListNotes extends ActionSupport
{
	private String errMsg;
	private Collection<Note> notes;
	private Service service;
	public ListNotes()
	{
		super();
		service = new Service();
	}
	@Override
	public String execute() throws Exception
	{
		notes = service.getNotes();
		if (notes != null)
			return SUCCESS;
		errMsg = "数据库没电了>_<";
		return ERROR;
	}
	public Collection<Note> getNotes()
	{
		return notes;
	}
	public void setNotes(Collection<Note> notes)
	{
		this.notes = notes;
	}
	public String getErrMsg()
	{
		return errMsg;
	}
	public void setErrMsg(String errMsg)
	{
		this.errMsg = errMsg;
	}
}
