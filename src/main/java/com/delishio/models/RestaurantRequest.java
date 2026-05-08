package com.delishio.models;

public class RestaurantRequest {

    private int requestId;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String status;
    private String document;
	
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	

	public String getDocument() {
	    return document;
	}

	public void setDocument(String document) {
	    this.document = document;
	}
	@Override
	public String toString() {
		return "RestaurantRequest [requestId=" + requestId + ", name=" + name + ", email=" + email + ", phone=" + phone
				+ ", address=" + address + ", status=" + status + ", document=" + document + "]";
	}
	
	
}