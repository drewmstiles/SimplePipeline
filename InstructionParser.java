import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;


public class MipsInsturctionGenerator
{	
	
	public static void main(String[] args) {
		if (args.length == 1) {
			readInstructionFile(new File(args[0]));
		}
		else if (args.length == NUM_ITYPE_FIELDS || args.length == NUM_RTYPE_FIELDS) {
			formatAndPrint(convert(args));
		}
		else {
			throw new RuntimeException("Unknown instruction type");
		}
	}
	
	private static void readInstructionFile(File f) {
		Scanner scan = null;
		try {
			scan = new Scanner(f);
			while(scan.hasNext()) {
				String instruction = scan.nextLine();
				formatAndPrint(convert(instruction.split("#")[0].split("\\s")));
			}
		} 
		catch (FileNotFoundException ex) {
			ex.printStackTrace();
		}
		finally {
			scan.close();
		}
	}
	
	private static String[] convert(String[] instr) {
		int[] fieldLengths = null; 
		if (instr.length == (NUM_ITYPE_FIELDS)) {
			fieldLengths = ITYPE_FIELD_LENGTHS;
		}
		else if (instr.length == (NUM_RTYPE_FIELDS)) {
			fieldLengths = RTYPE_FIELD_LENGTHS;
		}
		
		String binary = "";
		for (int i = 0; i < instr.length; i++) {
			String b = exec(instr[i]);
			while (b.length() < fieldLengths[i]) {
				b = "0" + b; // sign extend		
			}
			binary += b;
		}
		
		return binary.split(EQUAL_SIZE_SUBSTRINGS_REGEX);
	}
	
	
	private static String exec(String field) {
		String[] cmd =  { 
			"/bin/sh", 
			"-c", 
			"echo \"ibase=A; obase=2;" + field + ";\" | bc" 
		};
		
		try {
			Process p = Runtime.getRuntime().exec(cmd);
			p.waitFor();
			String s = (new BufferedReader(new InputStreamReader(p.getInputStream()))).readLine();
			return s;
		} 
		catch (IOException ex) {
			ex.printStackTrace();
			return null;
		} 
		catch (InterruptedException ex) {
			ex.printStackTrace();
			return null;
		}
		
	}
	
	
	private static void formatAndPrint(String[] out) {
		for (int i = 0; i < out.length; i++) {
			System.out.printf("IM[%d] = 8'b%s;\n", memIndex++, out[i]);
		}
	}
	
	private static final int NUM_ITYPE_FIELDS = 4;
	private static final int NUM_RTYPE_FIELDS = 6;
	private static final int[] ITYPE_FIELD_LENGTHS = { 6, 5, 5, 16 };
	private static final int[] RTYPE_FIELD_LENGTHS = { 6, 5, 5, 5, 5, 6 };
	private static final String EQUAL_SIZE_SUBSTRINGS_REGEX = "(?<=\\G.{8})"; // size of 8
	
	private static int memIndex = 0;
}


