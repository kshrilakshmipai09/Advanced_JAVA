/*
   4c.Develop a Swing program in Java to display a message “Digital Clock is pressed” or
      “Hour Glass is pressed” depending upon the Jbutton with image either Digital Clock 
      or Hour Glass is pressed by implementing the event handling mechanism with addActionListener( ).
 */
package Swings;
	import java.awt.Font;
	import java.awt.event.ActionEvent;
	import java.awt.event.ActionListener;
	import javax.swing.*;
	public class ButtonPressed4c implements ActionListener {
	    JLabel label;
	    JButton digitalBtn, hourGlassBtn;
	    
	    ButtonPressed4c() {
	        JFrame frame = new JFrame("Image Button Example");
	        label = new JLabel();
	        label.setBounds(50, 40, 700, 80);
	        label.setFont(new Font("Arial", Font.BOLD, 18));
	        
	        ImageIcon digitalIcon = new ImageIcon(getClass().getResource("/Swings/digital.png"));
	        ImageIcon hourGlassIcon = new ImageIcon("/Swings/hourglass.png");
	        
	        digitalBtn = new JButton(digitalIcon);
	        hourGlassBtn = new JButton(hourGlassIcon);
	        digitalBtn.setBounds(100, 180, 280, 200);
	        hourGlassBtn.setBounds(420, 180, 280, 200);
	        
	        digitalBtn.addActionListener(this);
	        hourGlassBtn.addActionListener(this);
	        
	        frame.add(digitalBtn);
	        frame.add(hourGlassBtn);
	        frame.add(label);
	        frame.setSize(750, 500);
	        frame.setLayout(null);
	        frame.setVisible(true);
	        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	    }
	    
	    public void actionPerformed(ActionEvent e) {
	        if (e.getSource() == digitalBtn) {
	            label.setText("Digital Clock is pressed");
	        }
	        else if (e.getSource() == hourGlassBtn) {
	            label.setText("Hour Glass is pressed");
	        }
	    }
	    
	    public static void main(String[] args) {
	        new ButtonPressed4c();
	    }
	}
