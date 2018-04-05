package entities;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement()
public class Ders {
	
	private String dersKodu;
	private String dersAdi;
	private String dersIcerik;
	
	public Ders(String dersKodu, String dersAdi, String dersIcerik) {
		super();
		this.dersKodu = dersKodu;
		this.dersAdi = dersAdi;
		this.dersIcerik = dersIcerik;
	}
	
	
	
	public Ders() {
		super();
	}


	@XmlElement
	public String getDersKodu() {
		return dersKodu;
	}
	
	
	public void setDersKodu(String dersKodu) {
		this.dersKodu = dersKodu;
	}
	
	@XmlElement
	public String getDersAdi() {
		return dersAdi;
	}
	
	
	public void setDersAdi(String dersAdi) {
		this.dersAdi = dersAdi;
	}
	
	@XmlElement
	public String getDersIcerik() {
		return dersIcerik;
	}
	
	
	public void setDersIcerik(String dersIcerik) {
		this.dersIcerik = dersIcerik;
	}
	
	
	

}
