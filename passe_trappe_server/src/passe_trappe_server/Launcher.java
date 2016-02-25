package passe_trappe_server;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;


public class Launcher {
	static ServerSocket ss;
	protected final static int port = 19999;
	static Socket connection;

	static boolean first;
	static StringBuffer process;
	static String TimeStamp;
	
	static Map<String, Integer> playersScores;

	public Launcher() {
		try {
			ss = new ServerSocket(11111);
			playersScores = new HashMap<String, Integer>();
		} catch (IOException ex) {
			Logger.getLogger(Launcher.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

	public static void main(String[] args) {
		try{
			ss = new ServerSocket(port);
			System.out.println("SocketServer Initialized");
			int character;
			while (true) {
				connection = ss.accept();

				BufferedInputStream is = new BufferedInputStream(connection.getInputStream());
				InputStreamReader isr = new InputStreamReader(is);
				process = new StringBuffer();
				
				while((character = isr.read()) != 13) {
					process.append((char)character);
				}
				
				System.out.println(process);
				//need to wait 10 seconds for the app to update database
				try {
					Thread.sleep(10000);
				}
				catch (Exception e){}
				
				BufferedOutputStream os = new BufferedOutputStream(connection.getOutputStream());
				OutputStreamWriter osw = new OutputStreamWriter(os, "US-ASCII");
				osw.write(process.toString());
				osw.flush();
			}
		}
		catch (IOException e) {}
		try {
			connection.close();
		}
		catch (IOException e) {}
	}
}
