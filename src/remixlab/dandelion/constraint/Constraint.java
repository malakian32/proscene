/*******************************************************************************
 * dandelion (version 1.0.0)
 * Copyright (c) 2014 National University of Colombia, https://github.com/remixlab
 * @author Jean Pierre Charalambos, http://otrolado.info/
 *     
 * All rights reserved. Library that eases the creation of interactive
 * scenes, released under the terms of the GNU Public License v3.0
 * which is available at http://www.gnu.org/licenses/gpl.html
 ******************************************************************************/
package remixlab.dandelion.constraint;

import remixlab.dandelion.core.Frame;
import remixlab.dandelion.geom.*;
import remixlab.util.Util;

/**
 * An interface class for Frame constraints.
 * <p>
 * This class defines the interface for the constraint that can be applied to a
 * Frame to limit its motion. Use
 * {@link remixlab.dandelion.core.Frame#setConstraint(Constraint)} to associate a
 * Constraint to a Frame (default is a {@code null}
 * {@link remixlab.dandelion.core.Frame#constraint()}.
 */
public abstract class Constraint {
	protected Vec sclConstr = new Vec();
	
	/**
	 * Filters the translation applied to the Frame. This default implementation
	 * is empty (no filtering).
	 * <p>
	 * Overload this method in your own Constraint class to define a new
	 * translation constraint. {@code frame} is the Frame to which is applied the
	 * translation. You should refrain from directly changing its value in the
	 * constraint. Use its {@link remixlab.dandelion.core.Frame#position()} and update
	 * the translation accordingly instead.
	 * <p>
	 * {@code translation} is expressed in the local Frame coordinate system. Use
	 * {@link remixlab.dandelion.core.Frame#inverseTransformOf(Vec)} to express it
	 * in the world coordinate system if needed.
	 */
	public Vec constrainTranslation(Vec translation, Frame frame) {
		return translation.get();
	}

	/**
	 * Filters the rotation applied to the {@code frame}. This default
	 * implementation is empty (no filtering).
	 * <p>
	 * Overload this method in your own Constraint class to define a new rotation
	 * constraint. See {@link #constrainTranslation(Vec, Frame)} for details.
	 * <p>
	 * Use {@link remixlab.dandelion.core.Frame#inverseTransformOf(Vec)} on the
	 * {@code rotation} {@link remixlab.dandelion.geom.Quat#axis()} to express
	 * {@code rotation} in the world coordinate system if needed.
	 */
	public Orientable constrainRotation(Orientable rotation, Frame frame) {
		return rotation.get();
	}
	
	public Vec scalingConstraint() {
		return sclConstr;
	}

	public void setScalingConstraint(Vec c) {
		sclConstr = c.get();
	}
	
	public void setScalingConstraint(float x, float y) {
		sclConstr.setX(x);
		sclConstr.setY(y);
	}
	
	public void setScalingConstraint(float x, float y, float z) {
		sclConstr.setX(x);
		sclConstr.setY(y);
		sclConstr.setZ(z);
	}
	
	/**
	 * Filters the scaling applied to the Frame.
	 */	
	public Vec constrainScaling(Vec scaling, Frame frame) {
		if(frame.is2D())
			return new Vec(Util.nonZero(sclConstr.x()) ? 1 : scaling.x(),
							       Util.nonZero(sclConstr.y()) ? 1 : scaling.y());
		else
			return new Vec(Util.nonZero(sclConstr.x()) ? 1 : scaling.x(),
				             Util.nonZero(sclConstr.y()) ? 1 : scaling.y(),
				             Util.nonZero(sclConstr.z()) ? 1 : scaling.z());
	}
}
