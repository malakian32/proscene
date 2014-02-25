/*********************************************************************************
 * TerseHandling
 * Copyright (c) 2014 National University of Colombia, https://github.com/remixlab
 * @author Jean Pierre Charalambos, http://otrolado.info/
 *     
 * All rights reserved. Library that eases the creation of interactive
 * scenes, released under the terms of the GNU Public License v3.0
 * which is available at http://www.gnu.org/licenses/gpl.html
 *********************************************************************************/
package remixlab.tersehandling.event;

import remixlab.tersehandling.event.shortcut.ClickShortcut;
import remixlab.util.EqualsBuilder;
import remixlab.util.HashCodeBuilder;

/**
 * A click event encapsulates a {@link remixlab.tersehandling.event.shortcut.ClickShortcut} and it's defined by the
 * number of clicks. A click event holds the position where the event occurred ({@link #x()} and {@link #y()}).
 * 
 */
public class ClickEvent extends TerseEvent {
	@Override
	public int hashCode() {
		return new HashCodeBuilder(17, 37).
						appendSuper(super.hashCode()).
						append(x).
						append(y).
						append(button).
						append(numberOfClicks).
						toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (obj == this)
			return true;
		if (obj.getClass() != getClass())
			return false;

		ClickEvent other = (ClickEvent) obj;
		return new EqualsBuilder()
						.appendSuper(super.equals(obj))
						.append(button, other.button)
						.append(numberOfClicks, other.numberOfClicks)
						.append(x, other.x)
						.append(y, other.y)
						.isEquals();
	}

	protected Float x, y;
	protected final Integer numberOfClicks;
	protected final Integer button;

	/**
	 * Constructs a single click ClickEvent at the given position and from the given button defining the events
	 * {@link #shortcut()}
	 * 
	 * @param x
	 * @param y
	 * @param b
	 */
	public ClickEvent(float x, float y, int b) {
		this.x = x;
		this.y = y;
		this.button = b;
		this.numberOfClicks = 1;
	}

	/**
	 * Constructs a ClickEvent at the given position, from the given button defining the events {@link #shortcut()}, and
	 * with the given number of clicks.
	 * 
	 * @param x
	 * @param y
	 * @param b
	 * @param clicks
	 */
	public ClickEvent(float x, float y, int b, int clicks) {
		this.x = x;
		this.y = y;
		this.button = b;
		this.numberOfClicks = clicks;
	}

	/**
	 * Constructs a ClickEvent at the given position, from the given button and modifiers which defines the events
	 * {@link #shortcut()}, and with the given number of clicks.
	 * 
	 * @param x
	 * @param y
	 * @param modifiers
	 * @param b
	 * @param clicks
	 */
	public ClickEvent(float x, float y, int modifiers, int b, int clicks) {
		super(modifiers);
		this.x = x;
		this.y = y;
		this.button = b;
		this.numberOfClicks = clicks;
	}

	protected ClickEvent(ClickEvent other) {
		super(other);
		this.x = new Float(other.x);
		this.y = new Float(other.y);
		this.button = new Integer(other.button);
		this.numberOfClicks = new Integer(other.numberOfClicks);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see remixlab.tersehandling.event.TerseEvent#get()
	 */
	@Override
	public ClickEvent get() {
		return new ClickEvent(this);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see remixlab.tersehandling.event.TerseEvent#shortcut()
	 */
	@Override
	public ClickShortcut shortcut() {
		return new ClickShortcut(modifiers(), button(), clickCount());
	}

	/**
	 * @return event x coordinate
	 */
	public float x() {
		return x;
	}

	/**
	 * @return event y coordinate
	 */
	public float y() {
		return y;
	}

	/**
	 * @return event number of clicks
	 */
	public int clickCount() {
		return numberOfClicks;
	}

	/**
	 * @return clicked button
	 */
	public int button() {
		return button;
	}
}
