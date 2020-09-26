package com.wizlif.rave_flutter;

import android.annotation.SuppressLint;
import android.util.Base64;

import java.nio.charset.StandardCharsets;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Encryption {
    private static final String ALGORITHM = "DESede";
    private static final String TRANSFORMATION = "DESede/ECB/PKCS5Padding";

    public static String getEncryptedData(String unEncryptedString, String encryptionKey) {

        if (unEncryptedString != null && encryptionKey != null) {
            try {
                return encrypt(unEncryptedString, encryptionKey);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    private static String encrypt(String data, String key) {

        try {
            @SuppressLint({"NewApi", "LocalSuppress"}) byte[] keyBytes = key.getBytes(StandardCharsets.UTF_8);
            SecretKeySpec skey = new SecretKeySpec(keyBytes, ALGORITHM);
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);

            cipher.init(Cipher.ENCRYPT_MODE, skey);
            @SuppressLint({"NewApi", "LocalSuppress"}) byte[] plainTextBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] buf = cipher.doFinal(plainTextBytes);
            return Base64.encodeToString(buf, Base64.DEFAULT);
        } catch (Exception e) {
            return "";
        }

    }
}