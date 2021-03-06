/*******************************************************************************
 * TerseHandling (version 1.0.0)
 * Copyright (c) 2014 National University of Colombia, https://github.com/remixlab
 * @author Jean Pierre Charalambos, http://otrolado.info/
 *     
 * All rights reserved. Library that eases the creation of interactive
 * scenes, released under the terms of the GNU Public License v3.0
 * which is available at http://www.gnu.org/licenses/gpl.html
 ******************************************************************************/
package remixlab.tersehandling.generic.agent;

import remixlab.tersehandling.core.TerseHandler;
import remixlab.tersehandling.generic.profile.GenericKeyboardProfile;

/**
 * This class is provided purely for symmetry reasons with the events and shortcuts API.
 * Only needed if you plan to implement your own KeyboardAgent.
 * 
 * @see remixlab.dandelion.agent.KeyboardAgent
 *
 * @param <K>
 */
public class GenericKeyboardAgent<K extends GenericKeyboardProfile<?>> extends GenericActionableAgent<K> {	
	public GenericKeyboardAgent(K k, TerseHandler scn, String n) {
		super(k, scn, n);
	}
	
	public K keyboardProfile() {
		return profile();
	}

	public void setKeyboardProfile(K kprofile) {
		setProfile(profile);
	}
}
