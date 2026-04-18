/* 1c. Linked List Programs

     8.Write a Java program to insert the specified element at the end of
       a linked list.( using l_listobj.offerLast("Pink"))
*/
package basic;
import java.util.*;
public class p8LinkedList1c {
public static void main(String[] args) {
		// TODO Auto-generated method stub

		LinkedList<String> ls = new LinkedList<>();
		ls.add("Orange");
		ls.add("geen");
		ls.add("pink");
		ls.add("red");
		ls.add("Blue");
		System.out.println(ls);
		ls.addLast("pink");
		System.out.println(ls);
	
	}

}

