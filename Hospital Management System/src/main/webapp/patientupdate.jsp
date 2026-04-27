<%@ page import="com.model.Patient" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Patient - Hospital Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .header {
            background: linear-gradient(135deg, #ffc107, #ff9800);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h2 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        .form-container {
            padding: 40px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #ffc107;
            box-shadow: 0 0 0 3px rgba(255,193,7,0.1);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #ffc107, #ff9800);
            color: white;
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: transform 0.2s;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
        }
        
        .btn-back {
            background: #6c757d;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
            transition: background 0.3s;
        }
        
        .btn-back:hover {
            background: #5a6268;
        }
        
        .btn-search {
            background: #17a2b8;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 10px;
            width: 100%;
            transition: background 0.3s;
        }
        
        .btn-search:hover {
            background: #138496;
        }
        
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            animation: slideDown 0.3