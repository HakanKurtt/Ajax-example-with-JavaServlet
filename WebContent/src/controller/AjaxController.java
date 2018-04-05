package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.sax.SAXResult;

import com.google.gson.Gson;

import entities.*;

import dbconnectionlib.DbConnection;

/**
 * Servlet implementation class AjaxController
 */
@WebServlet("/ders")
public class AjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		PrintWriter out= response.getWriter();
		Gson gson=new Gson(); 
		//Veritabanýna eriþim.
		DbConnection db=new DbConnection();
		
		
		Ders ders=db.selectTable();
		
		StringWriter sw=new StringWriter();
		
		if(action.equalsIgnoreCase("xmldata")) {
			//Eðer request parametresi ile gelen deðiþken deðeri xmldata ise veriyi JSON döndür.
			try {
				//JAXB kullanarak veritabanýndan çekilen verilerin XML'e dönüþtürülmesi.
				JAXBContext jaxbcontext=null;
				Marshaller jaxbMarshaller = null;
				jaxbcontext=JAXBContext.newInstance(Ders.class);
				jaxbMarshaller=jaxbcontext.createMarshaller();
				jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
				response.setContentType("application/xml");
				
				//XML formatýndan Stringe dönüþtürülmesi.
				jaxbMarshaller.marshal(ders, sw); 
				
				out.print(sw);
				
			} catch (JAXBException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			}
			
			
		}
		else if(action.equalsIgnoreCase("jsondata")){
		//Eðer request parametresiyle gelen deðiþken deðeri jsondata ise veriyi JSON olarak döndür.
			out.print(gson.toJson(ders));
			out.flush();
			out.close();
		
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String veri,data;
	      String mod;
	      PrintWriter out= response.getWriter();
	      DbConnection db=new DbConnection();
	      
	      
	      
	      mod=request.getParameter("mod");
	      
	      if(mod.equalsIgnoreCase("3")) {
	    	  veri=request.getParameter("dersAd");
	      }else if(mod.equalsIgnoreCase("4")) {
	    	  veri=request.getParameter("dersIcerik");
	      }else {
	    	  veri=request.getParameter("dersKodu");
	      }
	      
	      db.updateTable(veri, mod);
	      
	      
	      
	}
	
	@Override
	  protected void doPut(HttpServletRequest req, HttpServletResponse resp)
	          throws ServletException, IOException {
	      /*String veri;
	      String mod;
	      PrintWriter out= resp.getWriter();
	      DbConnection db=new DbConnection();
	      
	      
	      mod=req.getParameter("veri");
	      
	      out.print(mod);*/
	  }
	
	

}
