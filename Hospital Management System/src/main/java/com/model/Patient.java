package com.model;

import java.util.Date;
import java.text.SimpleDateFormat;

public class Patient {
    private int patientId;
    private String patientName;
    private int age;
    private String gender;
    private Date admissionDate;
    private String ailment;
    private String assignedDoctor;
    
    public Patient() {}
    
    public Patient(int patientId, String patientName, int age, String gender, 
                   Date admissionDate, String ailment, String assignedDoctor) {
        this.patientId = patientId;
        this.patientName = patientName;
        this.age = age;
        this.gender = gender;
        this.admissionDate = admissionDate;
        this.ailment = ailment;
        this.assignedDoctor = assignedDoctor;
    }
    
    // Getters
    public int getPatientId() { return patientId; }
    public String getPatientName() { return patientName; }
    public int getAge() { return age; }
    public String getGender() { return gender; }
    public Date getAdmissionDate() { return admissionDate; }
    public String getAilment() { return ailment; }
    public String getAssignedDoctor() { return assignedDoctor; }
    
    // Setters
    public void setPatientId(int patientId) { this.patientId = patientId; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
    public void setAge(int age) { this.age = age; }
    public void setGender(String gender) { this.gender = gender; }
    public void setAdmissionDate(Date admissionDate) { this.admissionDate = admissionDate; }
    public void setAilment(String ailment) { this.ailment = ailment; }
    public void setAssignedDoctor(String assignedDoctor) { this.assignedDoctor = assignedDoctor; }
    
    public String getFormattedDate() {
        if (admissionDate == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(admissionDate);
    }
}