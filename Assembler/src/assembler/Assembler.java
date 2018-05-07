/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package assembler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Scanner;

/**
 *
 * @author Sahar
 */
public class Assembler {

    /**
     * @param args the command line arguments
     */
    
   static String Imm(String s){
       
       int n=Integer.parseInt(s);
       String b=Integer.toBinaryString(n);
       String bin="";
       int count=16-b.length();
       for(int i=0;i<count;i++)
           bin+="0";
       
        return bin+b;
                       
    }
   
   static String  RegisterOpcode(String s)
    {
        if(s.contains("0"))
            return "000";
        else if(s.contains("1"))
             return "001";
        else if(s.contains("2"))
            return "010";
        else if(s.contains("3"))
            return "011";
        else if(s.contains("4"))
            return "100";
        else if(s.contains("5"))
            return "101";
        else
             return "";
                
    }
   
   
   

public static void Assembl(File file)throws IOException 
   {
       try {
         int count=0;
        Scanner scanner = new Scanner(file);
        FileOutputStream fos = new FileOutputStream("instructions.mem");
	BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
        bw.write("//format=mti addressradix=d dataradix=b version=1.0 wordsperline=1");
        bw.newLine();
        String Inst15_10="";
        String Inst9_6="";
        String Inst5_3="";
        String Inst2_0="";
        String Imm="";
         String[] in;

        while(scanner.hasNextLine() )
        {
            String input=scanner.nextLine();
            input=input.toLowerCase();
             if(input.contains("mov"))
             {
                 Inst15_10="000000";
                 Inst9_6="0000";
                 in=input.split(",");
                 Inst5_3=RegisterOpcode(in[0]);
                 Inst2_0=RegisterOpcode(in[1]);
             }
              else if(input.contains("add"))
             {
                 Inst15_10="000000";
                 Inst9_6="0001";
                 in=input.split(",");
                 Inst5_3=RegisterOpcode(in[0]);
                 Inst2_0=RegisterOpcode(in[1]);
             }
               else  if(input.contains("sub"))
             {
                 Inst15_10="000000";
                 Inst9_6="0010";
                 in=input.split(",");
                 Inst5_3=RegisterOpcode(in[0]);
                 Inst2_0=RegisterOpcode(in[1]);
             }
                else   if(input.contains("and"))
             {
                 Inst15_10="000000";
                 Inst9_6="0011";
                 in=input.split(",");
                 Inst5_3=RegisterOpcode(in[0]);
                 Inst2_0=RegisterOpcode(in[1]);
             }
               else if(input.contains("or"))
             {
                 Inst15_10="000000";
                 Inst9_6="0100";
                 in=input.split(",");
                 Inst5_3=RegisterOpcode(in[0]);
                 Inst2_0=RegisterOpcode(in[1]);
             }
                
                
                
                /////end of 2 operands in r-type
              else if(input.contains("not"))
             {
                 Inst15_10="000000";
                 Inst9_6="0000";
        
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
           else if(input.contains("neg"))
             {
                 Inst15_10="000000";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
            else if(input.contains("inc"))
             {
                 Inst15_10="000000";
                Inst9_6="0000";
        
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
         else if(input.contains("dec"))
             {
                 Inst15_10="000000";
                 Inst9_6="0000";
        
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
     
          else if(input.contains("rlc"))
             {
                 Inst15_10="000000";
                 Inst9_6="0000";
        
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
             else   if(input.contains("rrc"))
             {
                 Inst15_10="000000";
                 Inst9_6="0000";
        
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
                ///ebd 1 operand
             else if(input.contains("shl"))
             {
                 Inst15_10="000000";
                 Inst9_6="1000";
                 in=input.split(",");
                // String in2[]=in[1].split(",");
                 Inst5_3=RegisterOpcode(in[0]);//rsrc
                 Inst2_0=RegisterOpcode(in[2]);//rdst
                 Imm=Imm(in[1].trim());
             }
               else  if(input.contains("shr"))
             {
                 Inst15_10="000000";
                 Inst9_6="1001";
                 in=input.split(",");
                 Inst5_3=RegisterOpcode(in[0]);
                 Inst2_0=RegisterOpcode(in[2]);
                 Imm=Imm(in[1].trim());
             }
             else if(input.contains("in"))
             {
                 Inst15_10="010011";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
             else if(input.contains("out"))
             {
                 Inst15_10="010010";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
                 
             else if(input.contains("setc"))
             {
                 Inst15_10="110000";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0="000";
                 
             }
             else if(input.contains("clrc"))
             {
                 Inst15_10="110001";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0="000";
             }
              else if(input.contains("ldm"))
              {
                 Inst15_10="010110";
                 Inst9_6="0000";
                 in=input.split(",");
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(in[0]);
                 Imm=Imm(in[1].trim());

              }
             else if(input.contains("ldd"))
             {
                 Inst15_10="010111";
                 Inst9_6="0000";
                 in=input.split(",");
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(in[0]);
                 Imm=Imm(in[1].trim());
             }
             else if(input.contains("std"))
             {
                 Inst15_10="011000";
                 Inst9_6="0000";
                 in=input.split(",");
                 
                 Inst5_3=RegisterOpcode(in[0]);
                 Inst2_0="000";
                 Imm=Imm(in[1].trim());
             }
             
              else if(input.contains("push"))
              {
                 Inst15_10="010000";
                  Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
              }
             else if(input.contains("pop"))
             {
                 Inst15_10="010001";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
                 
             }
            
             else if(input.contains("jmp"))
             {
                 Inst15_10="100010";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
             else if(input.contains("jz"))
             {
                 Inst15_10="100100";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             
             }
             else if(input.contains("jc"))
             {
                 Inst15_10="100010";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
             else if(input.contains("jn"))
             {
                 Inst15_10="100101";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
             else if(input.contains("call"))
             {
                 Inst15_10="100011";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0=RegisterOpcode(input);
             }
             
             
             
           else if(input.contains("ret"))
               {
                 Inst15_10="010100";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0="000";
               }
           else if(input.contains("rti"))
             {
                 Inst15_10="010101";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0="000";
             }
             else if(input.contains("nop"))
             {
                 Inst15_10="010110";
                 Inst9_6="0000";
                 Inst5_3="000";
                 Inst2_0="000";
             }
             
             
                bw.write("   "+(count++)+":   "+Inst15_10+Inst9_6+Inst5_3+Inst2_0);
                bw.newLine();
                if(Imm!="")
                {
                 bw.write("   "+(count++)+":   "+Imm);
                 bw.newLine();
                 Imm="";
                 
                }
		
        }
        scanner.close();
        bw.close();
    } 
    catch (FileNotFoundException e) {
    }
        
        
        
        
    }
   

    public static void main(String[] args) throws IOException {
        // TODO code application logic here
        
        
        
        
        File file = new File("Testcase1_Code.txt");
        Assembl(file);
      String s="SHL R2, 4,R3";
      String[] s1=s.split(",");
      String a=s1[0];
      String a1=s1[1];
      String a2=s1[2];
      
      
    
    
     }
}
