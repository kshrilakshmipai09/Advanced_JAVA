/* 
   5c.Develop a Swing program in Java to add the countries USA, India, Vietnam, Canada, Denmark, 
      France, Great Britain, Japan, Africa, Greenland, Singapore into a JList and display the
      capital of the countries on console whenever the countries are selected on the list.
 */

package Swings;
import javax.swing.*;
import javax.swing.event.*;
import java.awt.*;
import java.util.HashMap;
import java.util.Map;
public class CountryCapital5c extends JFrame {
    private JList<String> countryList;
    private DefaultListModel<String> listModel;
    private Map<String, String> capitalMap;
    public CountryCapital5c() {
        setTitle("Country Capital Finder");
        setSize(350, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        // Initialize data structure (HashMap)
        capitalMap = new HashMap<>();
        capitalMap.put("USA", "Washington D.C.");
        capitalMap.put("India", "New Delhi");
        capitalMap.put("Vietnam", "Hanoi");
        capitalMap.put("Canada", "Ottawa");
        capitalMap.put("Denmark", "Copenhagen");
        capitalMap.put("France", "Paris");
        capitalMap.put("Great Britain", "London");
        capitalMap.put("Japan", "Tokyo");
        capitalMap.put("Africa", "Addis Ababa");
        capitalMap.put("Greenland", "Nuuk");
        capitalMap.put("Singapore", "Singapore");
        // Create List Model
        listModel = new DefaultListModel<>();
        for (String country : capitalMap.keySet()) {
            listModel.addElement(country);
        }
        // Create JList
        countryList = new JList<>(listModel);
        countryList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        countryList.setFont(new Font("Arial", Font.BOLD, 14));
        // Add Selection Listener
        countryList.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                if (!e.getValueIsAdjusting()) {
                    String selectedCountry = countryList.getSelectedValue();
                    if (selectedCountry != null) {
                        String capital = capitalMap.get(selectedCountry);
                        System.out.println("Capital of " + selectedCountry + " is: " + capital);
                    }
                }
            }
        });
        add(new JScrollPane(countryList), BorderLayout.CENTER);
    }
    public static void main(String[] args) {
        // Run on Event Dispatch Thread (Advanced practice)
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new CountryCapital5c().setVisible(true);
            }

        });

    }

}