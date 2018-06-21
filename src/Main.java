/**
 * Created by lucasdiniz on 15/05/2018.
 */

import flex.Lexer;

import java.io.File;
import java.io.FileReader;

public class Main {

    public static void main(String args[]) {
        Lexer s;

        try{
            s = new Lexer(new FileReader(new File( System.getProperty("user.dir") + "/src/input.txt")));
        } catch(Exception e){
            System.out.println(e.getMessage());
        }

    }

}
