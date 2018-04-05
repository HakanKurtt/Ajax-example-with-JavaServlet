package dbconnectionlib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


import entities.Ders;

public class DbConnection {

	public static void main(String[] args) {
		
		
	

	

	}
	
	public static Connection getConnection() throws Exception{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Driver is installed");
		} catch (ClassNotFoundException e) {
			
			System.out.println("Mysql driver not found"+e);
		}
		
		String url="jdbc:mysql://localhost:3306/dersler?useUnicode=true&characterEncoding=UTF-8";
		String user="root";
		String password="";
		
		Connection con=null;
		
		try {
			con=DriverManager.getConnection(url, user, password);
			System.out.println("Connection is successful");
		} catch (SQLException e) {
			System.out.println("Connection failed.");
		}
		
		return con;
	}
	
	public static void insertTable() {
		String dersKodu="BSM 458";
		String dersAdi="Að Programlama";
		String dersIcerik="Ajax, Soket Programlama";
		
		
		
		try {
			Connection con=getConnection();
			PreparedStatement insert=con.prepareStatement("INSERT INTO ders(dersKodu,dersAdi,dersIcerik) VALUES ('"+dersKodu+"','"+dersAdi+"','"+dersIcerik+"')");
			insert.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}finally {System.out.println("Ekleme iþlemi baþarýlý!");}
	}
	
	public static void updateTable(String veri,String mod) {
		
		int modu=Integer.parseInt(mod);
		
		PreparedStatement update=null;
		
		try {
			Connection con=getConnection();
			if(modu==1) { //tüm tabloyu
				/*update=con.prepareStatement("UPDATE ders SET dersKodu = ?, dersAdi = ?, dersIcerik = ? WHERE id=1");
				
				//preparedstatement parametrelerini ayarla.
				update.setString(1, dKodu);
				update.setString(2, dAdi);
				update.setString(3, dIcerik);
				*/
			}else if(modu==2) { //sadece ders kodunu
				update=con.prepareStatement("UPDATE ders SET dersKodu = ? WHERE id=1");
				
				update.setString(1, veri);
			}else if(modu==3) {//sadece ders adýný
				update=con.prepareStatement("UPDATE ders SET dersAdi = ? WHERE id=1");
				
				update.setString(1, veri);
			}else if(modu==4) {//sadece dersIcerigini
				update=con.prepareStatement("UPDATE ders SET dersIcerik = ? WHERE id=1");
				
				update.setString(1, veri);
			}
			
			
			
			update.executeUpdate();
			update.close();
			
		}catch(Exception e) {
			
		}finally {System.out.println("Güncelleme iþlemi tamam!"); }
	}
	
	public static void createTable() {
		
		try {
			Connection con=getConnection();
			PreparedStatement create=con.prepareStatement("CREATE TABLE IF NOT EXISTS ders(id int NOT NULL AUTO_INCREMENT,dersKodu varchar(255),dersAdi varchar(255), dersIcerik varchar(255),PRIMARY KEY(id))");
			create.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e);
		}finally {System.out.println("Fonksiyon baþarýyla tamamlandý.");}
		
		
	}
	
	
	@XmlElement(name="ders")
	public static Ders selectTable() {
		
		ArrayList<Ders> dersList=new ArrayList<>();
		Ders d=new Ders();
		
		try {
			Connection con=getConnection();
			PreparedStatement select=con.prepareStatement("SELECT * FROM ders");

			ResultSet result=select.executeQuery();
			
			
			
			while(result.next()) {
				d=new Ders(result.getString("dersKodu"),result.getString("dersAdi"),result.getString("dersIcerik"));
				dersList.add(d);
			}
			
			
			
		} catch (Exception e) {
			System.out.println(e);
		}finally {System.out.println("basarýlý");}
		
		return d;
	}
	

}
