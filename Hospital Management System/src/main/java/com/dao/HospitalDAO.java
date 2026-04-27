package com.dao;

import com.model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HospitalDAO {
    // Update these credentials according to your MySQL setup
    private static final String URL = "jdbc:mysql://localhost:3306/HospitalDB?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "password"; // Change this to your MySQL password
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    // Add Patient
    public boolean addPatient(Patient patient) {
        String sql = "INSERT INTO Patients (PatientID, PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, patient.getPatientId());
            pstmt.setString(2, patient.getPatientName());
            pstmt.setInt(3, patient.getAge());
            pstmt.setString(4, patient.getGender());
            pstmt.setDate(5, new java.sql.Date(patient.getAdmissionDate().getTime()));
            pstmt.setString(6, patient.getAilment());
            pstmt.setString(7, patient.getAssignedDoctor());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update Patient
    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE Patients SET PatientName=?, Age=?, Gender=?, AdmissionDate=?, Ailment=?, AssignedDoctor=? WHERE PatientID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, patient.getPatientName());
            pstmt.setInt(2, patient.getAge());
            pstmt.setString(3, patient.getGender());
            pstmt.setDate(4, new java.sql.Date(patient.getAdmissionDate().getTime()));
            pstmt.setString(5, patient.getAilment());
            pstmt.setString(6, patient.getAssignedDoctor());
            pstmt.setInt(7, patient.getPatientId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete Patient
    public boolean deletePatient(int patientId) {
        String sql = "DELETE FROM Patients WHERE PatientID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, patientId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get All Patients
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients ORDER BY PatientID";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                patients.add(extractPatientFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }
    
    // Get Patient by ID
    public Patient getPatientById(int patientId) {
        String sql = "SELECT * FROM Patients WHERE PatientID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, patientId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractPatientFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Report: Patients by Date Range
    public List<Patient> getPatientsByDateRange(String startDate, String endDate) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE AdmissionDate BETWEEN ? AND ? ORDER BY AdmissionDate";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, java.sql.Date.valueOf(startDate));
            pstmt.setDate(2, java.sql.Date.valueOf(endDate));
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                patients.add(extractPatientFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }
    
    // Report: Patients by Ailment
    public List<Patient> getPatientsByAilment(String ailment) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE LOWER(Ailment) LIKE LOWER(?) ORDER BY PatientID";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + ailment + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                patients.add(extractPatientFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }
    
    // Report: Patients by Doctor
    public List<Patient> getPatientsByDoctor(String doctorName) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE LOWER(AssignedDoctor) LIKE LOWER(?) ORDER BY PatientID";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + doctorName + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                patients.add(extractPatientFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }
    
    private Patient extractPatientFromResultSet(ResultSet rs) throws SQLException {
        Patient patient = new Patient();
        patient.setPatientId(rs.getInt("PatientID"));
        patient.setPatientName(rs.getString("PatientName"));
        patient.setAge(rs.getInt("Age"));
        patient.setGender(rs.getString("Gender"));
        patient.setAdmissionDate(rs.getDate("AdmissionDate"));
        patient.setAilment(rs.getString("Ailment"));
        patient.setAssignedDoctor(rs.getString("AssignedDoctor"));
        return patient;
    }
}