package com.shma.yusuf.shma;

public class BusinessDetails {
    private String PlaceID;
    private String discount;
    private String iconUrl;

    public BusinessDetails(){

    }

    public BusinessDetails(String discount, String iconUrl) {
        this.discount = discount;
        this.iconUrl = iconUrl;
    }
    public String getPlaceID() {
        return PlaceID;
    }

    public void setPlaceID(String placeID) {
        PlaceID = placeID;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getIconUrl() {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }







}
