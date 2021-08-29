/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

/**
 *
    * @author Sony
 */
// clase para la encriptación de datos

public class Encriptacion {
    public static String MD2 = "MD2";
    public static String MD5 = "MD5";
    public static String SHA1 = "SHA-1";
    public static String SHA256 = "SHA-256";
    public static String SHA384 = "SHA-384";
    public static String SHA512 = "SHA-512";
    //obtiene un arreglo de tipo byte y retorna un hexadecimal.
    private static String toHexadecimal(byte[] digest){
        String hash="";
        for (byte aux: digest) {
            int b=aux & 0xff;
            if(Integer.toHexString(b).length()==1) hash += "0";
            hash += Integer.toHexString(b);
        }
        return hash;
    }  
    //utilice el metodo especificado y lo aplica a la cadena
    public static String getStringMessageDigest(String cadena, String algoritm){
        byte[] digest=null;
        byte[] buffer=cadena.getBytes();
        try {
            MessageDigest messageDigest=MessageDigest.getInstance(algoritm);
            messageDigest.reset();
            messageDigest.update(buffer);
            digest=messageDigest.digest();            
        } catch (NoSuchAlgorithmException e) {
             System.out.println("Error creando digest");
        }  
        return toHexadecimal(digest);
    }
    
    public  String Desencriptar(String textoEncriptado) throws Exception {
 
        String secretKey = "qualityinfosolutions"; //llave para desenciptar datos
        String base64EncryptedString = "";
 
        try {
            byte[] message = Base64.decodeBase64(textoEncriptado.getBytes("utf-8"));
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digestOfPassword = md.digest(secretKey.getBytes("utf-8"));
            byte[] keyBytes = Arrays.copyOf(digestOfPassword, 24);
            SecretKey key = new SecretKeySpec(keyBytes, "DESede");
 
            Cipher decipher = Cipher.getInstance("DESede");
            decipher.init(Cipher.DECRYPT_MODE, key);
 
            byte[] plainText = decipher.doFinal(message);
 
            base64EncryptedString = new String(plainText, "UTF-8");
 
        } catch (Exception ex) {
        }
        return base64EncryptedString;
}
}

