---
title: "Geospatial"
description: >
    WIP notes on geospatial data
---

## Types of Geospatial Data

**Raster data** - Suitable for continuous information without fixed borders, represented as a grid of cells 
  with values indicating observed features. It is often monitored at regular intervals and interpolated to 
  create a continuous surface.

**Vector data** - Uses points, lines, and polygons to represent spatial properties, including points of interest, 
  transportation networks, administrative boundaries, and land parcels, often used for discrete data with precise 
  positions or hard constraints.

## Storage Formats for Geospatial Data

- ESRI Shapefile (vector)
- GeoJSON (vector)
- Erdas Imagine Image File Format (EIF)
- GeoTIFF
- Geopackage (GPKG)
- GeoJSON
- Light Detection Ranging (LiDAR)

## Python Packages for Geospatial Data Analysis

| Package    | Suitable for Data Type  |
|------------|-------------------------|
| Geopandas  | Vector Data             |
| Folium     | Point clouds            |
| ipyleaflet | Point clouds            |
| Rasterio   | Raster Data             |
| Geoplot    | Vector Data             |
| Shapely    |                         |
| Pandas     |                         |
| Cartopy    |                         |