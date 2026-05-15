package com.Furnistock.util;

import jakarta.servlet.ServletContext;
import java.net.MalformedURLException;
import java.util.HashSet;
import java.util.Set;

public class ImagePathResolver {

    private static final String IMAGES_FOLDER = "/images/";
    private static final String DEFAULT_IMAGE = IMAGES_FOLDER + "furnistock-2.webp";
    private static final String[] EXTENSIONS = {".jpg", ".jpeg", ".png", ".jfif", ".avif", ".webp"};
    private static final String[] KNOWN_IMAGE_PATHS = {
            "/images/Contemporary-sofa.webp",
            "/images/Dark-wallnut-bookcase.jfif",
            "/images/Decorartive-Accent-Piece.webp",
            "/images/Executive-Desk.avif",
            "/images/leather-sofa.jpg",
            "/images/modern-lounge-collection.jpg",
            "/images/modern-office-chair.webp",
            "/images/modern-sofa.jfif",
            "/images/monument-coffee-table.jpg",
            "/images/Oak-Cabinet.jpg",
            "/images/Premium-bedroom-bed.jpeg",
            "/images/velvet.avif",
            "/images/Wall-shelf-unit.webp",
            "/images/walnut-credenza.jpg",
            "/images/wooden-dinning-table.jpg"
    };

    public static String resolveImagePath(ServletContext context, String imageUrl, String furnitureName) {
        if (context == null) {
            return DEFAULT_IMAGE;
        }

        imageUrl = normalizeInput(imageUrl);

        if (imageUrl != null && !imageUrl.isEmpty()) {
            String resolved = resolveByImageUrl(context, imageUrl);
            if (resolved != null) {
                return resolved;
            }
        }

        String resolved = resolveByName(context, furnitureName);
        return resolved != null ? resolved : DEFAULT_IMAGE;
    }

    private static String resolveByImageUrl(ServletContext context, String imageUrl) {
        if (imageUrl.startsWith("http://") || imageUrl.startsWith("https://")) {
            return imageUrl;
        }

        String candidate;

        if (imageUrl.startsWith("/")) {
            candidate = imageUrl;
        } else {
            candidate = IMAGES_FOLDER + imageUrl;
        }

        if (resourceExists(context, candidate)) {
            return candidate;
        }

        if (!imageUrl.contains(".")) {
            for (String ext : EXTENSIONS) {
                candidate = IMAGES_FOLDER + imageUrl + ext;
                if (resourceExists(context, candidate)) {
                    return candidate;
                }
            }
        }

        return null;
    }

    public static String resolveByName(ServletContext context, String furnitureName) {
        if (furnitureName == null || furnitureName.isBlank()) {
            return null;
        }

        String normalizedName = normalize(furnitureName);

        String bestMatch = null;
        int bestDistance = Integer.MAX_VALUE;

        for (String path : KNOWN_IMAGE_PATHS) {
            if (!resourceExists(context, path)) {
                continue;
            }

            String filename = path.substring(path.lastIndexOf('/') + 1);
            String baseName = filename;
            int dot = filename.lastIndexOf('.');
            if (dot > 0) {
                baseName = filename.substring(0, dot);
            }

            String normalizedBase = normalize(baseName);

            if (normalizedBase.equals(normalizedName)) {
                return path;
            }

            if (normalizedBase.contains(normalizedName) || normalizedName.contains(normalizedBase)) {
                return path;
            }

            int distance = levenshteinDistance(normalizedName, normalizedBase);
            if (distance < bestDistance) {
                bestDistance = distance;
                bestMatch = path;
            }
        }

        return bestDistance <= 4 ? bestMatch : null;
    }

    @SuppressWarnings("unused")
    private static Set<String> getImagePaths(ServletContext context) {
        Set<String> imagePaths = new HashSet<>();
        Set<String> paths = context.getResourcePaths(IMAGES_FOLDER);
        if (paths != null) {
            imagePaths.addAll(paths);
        }
        return imagePaths;
    }

    private static String normalize(String input) {
        if (input == null) {
            return "";
        }
        return input.toLowerCase()
                .trim()
                .replaceAll("[^a-z0-9]+", "-")
                .replaceAll("^-+|-+$", "");
    }

    private static String normalizeInput(String input) {
        if (input == null) {
            return null;
        }
        String normalized = input.trim();
        if (normalized.isEmpty() || "default.jpg".equalsIgnoreCase(normalized)) {
            return null;
        }
        return normalized;
    }

    private static boolean resourceExists(ServletContext context, String path) {
        try {
            return context.getResource(path) != null;
        } catch (MalformedURLException e) {
            return false;
        }
    }

    private static int levenshteinDistance(String a, String b) {
        if (a == null || b == null) {
            return Integer.MAX_VALUE;
        }
        int[] costs = new int[b.length() + 1];
        for (int j = 0; j <= b.length(); j++) {
            costs[j] = j;
        }
        for (int i = 1; i <= a.length(); i++) {
            costs[0] = i;
            int prevCost = i - 1;
            for (int j = 1; j <= b.length(); j++) {
                int currentCost = costs[j];
                int substitutionCost = a.charAt(i - 1) == b.charAt(j - 1) ? 0 : 1;
                costs[j] = Math.min(
                        Math.min(costs[j] + 1, costs[j - 1] + 1),
                        prevCost + substitutionCost
                );
                prevCost = currentCost;
            }
        }
        return costs[b.length()];
    }
}
