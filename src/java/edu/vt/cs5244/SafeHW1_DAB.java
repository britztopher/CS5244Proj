/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.vt.cs5244;

import java.util.Map;
import java.util.Set;

/**
 *
 * @author christopherbritz
 */
public class SafeHW1_DAB implements DABEngine{
    
    private DABEngine wrappedDAB;
    
    public SafeHW1_DAB(DABEngine unsafeDAB){
        wrappedDAB = unsafeDAB;
    }

    @Override
    public synchronized void init(int i) {
        wrappedDAB.init(i);
    }

    @Override
    public synchronized int getSize() {
        return wrappedDAB.getSize();
    }

    @Override
    public  synchronized Set<Edge> getEdgesAt(int i, int i1) {
        return wrappedDAB.getEdgesAt(i, i1);
    }

    @Override
    public synchronized Player getOwnerAt(int i, int i1) {
        return wrappedDAB.getOwnerAt(i, i1);
    }

    @Override
    public synchronized boolean drawEdge(int i, int i1, Edge edge) {
        return wrappedDAB.drawEdge(i, i1, edge);
    }

    @Override
    public synchronized Map<Player, Integer> getScores() {
        return wrappedDAB.getScores();
    }

    @Override
    public synchronized Player getTurn() {
        return wrappedDAB.getTurn();
    }    
}
