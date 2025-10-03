package com.feast2feed;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/reverse-geocode")
public class ReverseGeocodeServlet extends HttpServlet {
    private static final String NOMINATIM_URL_TEMPLATE =
            "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=%s&lon=%s";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String lat = req.getParameter("lat");
        String lon = req.getParameter("lon");
        resp.setContentType("application/json;charset=UTF-8");

        if (lat == null || lon == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"Missing latitude or longitude parameters.\"}");
            return;
        }

        String urlStr = String.format(NOMINATIM_URL_TEMPLATE, lat, lon);
        StringBuilder responseStr = new StringBuilder();

        try {
            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Feast2Feed-App");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);

            int status = conn.getResponseCode();
            if (status != 200) {
                resp.setStatus(status);
                resp.getWriter().write("{\"error\":\"Reverse geocoding API error.\"}");
                return;
            }

            try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    responseStr.append(inputLine);
                }
            }
            resp.getWriter().write(responseStr.toString());
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}
