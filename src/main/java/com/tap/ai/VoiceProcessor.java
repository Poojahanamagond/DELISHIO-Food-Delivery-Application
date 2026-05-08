package com.tap.ai;

import java.util.ArrayList;
import java.util.List;

public class VoiceProcessor {

    public List<String> extractItems(String text) {

        text = text.toLowerCase();
        List<String> items = new ArrayList<>();

        if(text.contains("pizza")) items.add("pizza");
        if(text.contains("burger")) items.add("burger");
        if(text.contains("biryani")) items.add("biryani");
        if(text.contains("coffee")) items.add("coffee");
        if(text.contains("cake")) items.add("cake");

        return items;
    }
}