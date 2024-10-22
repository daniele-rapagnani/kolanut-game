let System = import("ecs/systems/System");

let PlatformSystem = {
    create = => {
        return { } @ PlatformSystem;
    },

    update = |dt, entities| -> {
        this.updateWithComponents(
            entities,
            ["Transform", "PlatformController", "TileCollider", "FrameAnimation", "Rigidbody"],
            |components, e| => {
                let pc = components.PlatformController;
                let fa = components.FrameAnimation;
                let rb = components.Rigidbody;
                let tr = components.Transform;
                let tc = components.TileCollider;

                let dashingTimeInterval = (pc.dashingTime + pc.dashingHold);

                if (pc.curDashingTime != null) {
                    pc.curDashingTime = pc.curDashingTime + dt;

                    if (pc.curDashingTime >= (dashingTimeInterval + pc.dashingRecharge)) {
                        pc.curDashingTime = null;
                    }
                }

                if (pc.jumpTime != null) {
                    pc.jumpTime = pc.jumpTime + dt;

                    if (pc.jumpTime >= pc.jumpRecharge) {
                        pc.jumpTime = null;
                    }
                }

                let isDashing = pc.curDashingTime != null && pc.curDashingTime < dashingTimeInterval;

                if (!isDashing) {
                    if (pc.controls.left) {
                        rb.velocity.x = -pc.speed;
                        tr.scale.x = -math.abs(tr.scale.x);
                    } else if (pc.controls.right) {
                        rb.velocity.x = pc.speed;
                        tr.scale.x = math.abs(tr.scale.x);
                    }
                }

                let moving = pc.controls.left || pc.controls.right;

                if (!pc.overrideAnimation) {
                    if (isDashing) {
                        fa->playAnimation(pc.animations.dash);
                    } else if (moving) {
                        fa->playAnimation(pc.animations.run);
                    } else {
                        fa->playAnimation(pc.animations.idle);
                        rb.velocity.x = 0;
                    }
                }

                if (!pc.grounded && tc.colliding.bottom) {
                    if (pc.sounds.land != null) {
                        pc.sounds.land->play();
                    }
                }

                pc.grounded = tc.colliding.bottom;

                if (pc.jumpTime == null && pc.grounded) {
                    if (pc.controls.jump && !isDashing) {
                        pc.controls.jump = false;
                        pc.jumpTime = 0.0;
                        rb.velocity.y = rb.velocity.y - pc.jumpSpeed;

                        if (pc.sounds.jump != null) {
                            pc.sounds.jump->play();
                        }
                    }
                }

                if (pc.controls.dash && moving && pc.curDashingTime == null) {
                    pc.controls.dash = false;

                    if (pc.sounds.dash != null) {
                        pc.sounds.dash->play();
                    }

                    rb.velocity.x = 0;
                    rb.velocity.y = 0;

                    if (pc.controls.left) {
                        pc.dashSpeed = -pc.speed * pc.dashingSpeedMult;
                    } else {
                        pc.dashSpeed = pc.speed * pc.dashingSpeedMult;
                    }

                    pc.curDashingTime = 0.0;
                }

                if (pc.curDashingTime != null 
                    && pc.curDashingTime >= pc.dashingHold
                    && pc.curDashingTime < dashingTimeInterval
                ) {
                    rb.velocity.x = pc.dashSpeed;
                }
            }
        );
    }
} @ System.create("PlatformSystem");

return PlatformSystem;