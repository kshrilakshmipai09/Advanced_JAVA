package com.dao;

import com.model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HospitalDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "password";   // ← Change if your MySQL password is different (try "root" also)

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver Loaded Successfully");
        } catch (Exception e) {
            System.out.println("Driver Loading Failed!");
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public boolean addPatient(Patient p) {
        String sql = "INSERT INTO Patients (PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?,?,?,?,?,?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, p.getPatientName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getAdmissionDate());
            ps.setString(5, p.getAilment());
            ps.setString(6, p.getAssignedDoctor());

            System.out.println("Trying to insert patient: " + p.getPatientName());
            int rows = ps.executeUpdate();
            System.out.println("Rows inserted: " + rows);
            return rows > 0;

        } catch (Exception e) {
            System.out.println("ERROR in addPatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients ORDER BY PatientID DESC";
        try (Connection con = getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Patient p = new Patient();
                p.setPatientID(rs.getInt("PatientID"));
                p.setPatientName(rs.getString("PatientName"));
                p.setAge(rs.getInt("Age"));
                p.setGender(rs.getString("Gender"));
                p.setAdmissionDate(rs.getString("AdmissionDate"));
                p.setAilment(rs.getString("Ailment"));
                p.setAssignedDoctor(rs.getString("AssignedDoctor"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Patient getPatientById(int id) {
        String sql = "SELECT * FROM Patients WHERE PatientID = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Patient p = new Patient();
                p.setPatientID(rs.getInt("PatientID"));
                p.setPatientName(rs.getString("PatientName"));
                p.setAge(rs.getInt("Age"));
                p.setGender(rs.getString("Gender"));
                p.setAdmissionDate(rs.getString("AdmissionDate"));
                p.setAilment(rs.getString("Ailment"));
                p.setAssignedDoctor(rs.getString("AssignedDoctor"));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public int getNextPatientId() {
        String sql = "SELECT MAX(PatientID) + 1 FROM Patients";
        int nextId = 1;   // default if table is empty
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next() && rs.getObject(1) != null) {
                nextId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }
    // Report 1: Patients by Date Range
    public List<Patient> getPatientsByDateRange(String fromDate, String toDate) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE AdmissionDate BETWEEN ? AND ? ORDER BY AdmissionDate";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Patient p = new Patient();
                p.setPatientID(rs.getInt("PatientID"));
                p.setPatientName(rs.getString("PatientName"));
                p.setAge(rs.getInt("Age"));
                p.setGender(rs.getString("Gender"));
                p.setAdmissionDate(rs.getString("AdmissionDate"));
                p.setAilment(rs.getString("Ailment"));
                p.setAssignedDoctor(rs.getString("AssignedDoctor"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Report 2: Patients by Ailment
    public List<Patient> getPatientsByAilment(String ailment) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE Ailment LIKE ? ORDER BY PatientID DESC";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, "%" + ailment + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Patient p = new Patient();
                p.setPatientID(rs.getInt("PatientID"));
                p.setPatientName(rs.getString("PatientName"));
                p.setAge(rs.getInt("Age"));
                p.setGender(rs.getString("Gender"));
                p.setAdmissionDate(rs.getString("AdmissionDate"));
                p.setAilment(rs.getString("Ailment"));
                p.setAssignedDoctor(rs.getString("AssignedDoctor"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Report 3: Patients by Doctor
    public List<Patient> getPatientsByDoctor(String doctor) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients WHERE AssignedDoctor LIKE ? ORDER BY PatientID DESC";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, "%" + doctor + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Patient p = new Patient();
                p.setPatientID(rs.getInt("PatientID"));
                p.setPatientName(rs.getString("PatientName"));
                p.setAge(rs.getInt("Age"));
                p.setGender(rs.getString("Gender"));
                p.setAdmissionDate(rs.getString("AdmissionDate"));
                p.setAilment(rs.getString("Ailment"));
                p.setAssignedDoctor(rs.getString("AssignedDoctor"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete Patient
    public boolean deletePatient(int id) {
        String sql = "DELETE FROM Patients WHERE PatientID = ?";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            System.out.println("Deleted rows: " + rows);   // For debugging
            return rows > 0;

        } catch (Exception e) {
            System.out.println("ERROR in deletePatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Update Patient
    public boolean updatePatient(Patient p) {
        String sql = "UPDATE Patients SET PatientName=?, Age=?, Gender=?, AdmissionDate=?, Ailment=?, AssignedDoctor=? WHERE PatientID=?";
        
        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, p.getPatientName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getAdmissionDate());
            ps.setString(5, p.getAilment());
            ps.setString(6, p.getAssignedDoctor());
            ps.setInt(7, p.getPatientID());

            int rows = ps.executeUpdate();
            System.out.println("Updated rows: " + rows);   // For debugging
            return rows > 0;

        } catch (Exception e) {
            System.out.println("ERROR in updatePatient: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    
	}
 // Call this after successful delete
    public void renumberDisplayIds() {
        try (Connection con = getConnection()) {
            String sql = "SET @row = 0;"
                       + "UPDATE your_table SET display_id = (@row := @row + 1) "
                       + "ORDER BY created_at ASC;";
            con.createStatement().execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public int addPatient(String name, int age, String gender, Connection con) {   // Add more parameters as needed
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            con = getConnection();
            
            // Logic to find smallest missing ID (reuses deleted numbers)
            String findNextId = """
                SELECT MIN(t1.display_id + 1) AS next_id 
                FROM patient t1 
                LEFT JOIN patient t2 ON t1.display_id + 1 = t2.display_id 
                WHERE t2.display_id IS NULL
                """;
            
            ps = conn.prepareStatement(findNextId);
            ResultSet rs = ps.executeQuery();
            
            int nextId = 1;   // Start from 1 if table is empty
            
            if (rs.next() && rs.getObject("next_id") != null) {
                nextId = rs.getInt("next_id");
            }
            
            // Insert with the reused/gap-filled ID
            String insertSql = "INSERT INTO patient (display_id, name, age, gender) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(insertSql);
            ps.setInt(1, nextId);
            ps.setString(2, name);
            ps.setInt(3, age);
            ps.setString(4, gender);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                return nextId;     // Return the assigned ID
            } else {
                return -1;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public boolean saveToDeletedPatients(Patient patient) {
        String sql = "INSERT INTO deleted_patients (PatientID, PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor, DeletedDate) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, patient.getPatientID());
            ps.setString(2, patient.getPatientName());
            ps.setInt(3, patient.getAge());
            ps.setString(4, patient.getGender());
            ps.setString(5, patient.getAdmissionDate());
            ps.setString(6, patient.getAilment());
            ps.setString(7, patient.getAssignedDoctor());
            
            int rows = ps.executeUpdate();
            return rows > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Patient> getAllDeletedPatients() {
        List<Patient> deletedList = new ArrayList<>();
        String sql = "SELECT * FROM deleted_patients ORDER BY DeletedDate DESC";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Patient p = new Patient();
                
                p.setPatientID(rs.getInt("PatientID"));
                p.setPatientName(rs.getString("PatientName"));
                p.setAge(rs.getInt("Age"));
                p.setGender(rs.getString("Gender"));
                p.setAdmissionDate(rs.getString("AdmissionDate"));
                p.setAilment(rs.getString("Ailment"));
                p.setAssignedDoctor(rs.getString("AssignedDoctor"));
                
                // Set deleted date if you have getter/setter in Patient class
                // p.setDeletedDate(rs.getTimestamp("DeletedDate"));
                
                deletedList.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deletedList;
    }
}