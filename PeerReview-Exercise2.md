# Peer-Review for Programming Exercise 2

## Peer-reviewer Information

- _name:_ Varun Thakkar
- _email:_ vathakkar@ucdavis.edu

## Solution Assessment

### Stage 1

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

All of the conditions have been satisified. The camera has a 5 by 5 crosshair that follows the camera. The camera works with all directions of movement and with the boost as well.
No issues.

---

### Stage 2

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

Although the camera movement and the draw_logic is perfect, puncakedev misses one thing - they don't give the player the opportunity to lag behind. The assignment stated that incase the player stops moving and starts to lag behind the camera, the camera would drag the player forward. Here, the player stays stagnant and doesn't fallback when movement input stops.

---

### Stage 3

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

The lerp does seem to work, but it works only over very small distances, making the overall movement very buggy. The lerp works pretty normally when using the boost to move.

---

### Stage 4

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [x] Unsatisfactory

---

#### Justification

The stage 4 camera doesn't seem to work at all. For any movement, the camera just travels from a further distance and stops at the target position. Not functioning at all from usage.

---

### Stage 5

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

Stage 5 works almost perfectly in terms of movement. The draw_logic code looks fine but never draws for some reason. I gave it a quick attempt to fix it but after some tries nothing changed. The speedup zone and total pushbox are so small relative to distance to target that the camera didn't seem to be working at first glance.

---

# Code Style

Overall puncakedev follows almost the guidelines from the godot style guide, here are jsut some of the infractions and exemplars I could point out

#### Style Guide Infractions

[declare two variables with the same value](https://github.com/ensemble-ai/exercise-2-camera-control-puncakedev/blob/4412ab6f1c9689d4e570302724f4a58dbe379a55/Obscura/scripts/camera_controllers/four_way.gd#L61) - could just reuse the variable by changing name
[variables aren't declared before functions](https://github.com/ensemble-ai/exercise-2-camera-control-puncakedev/blob/4412ab6f1c9689d4e570302724f4a58dbe379a55/Obscura/scripts/camera_controllers/horizontal_auto_scroll.gd#L21)

#### Style Guide Exemplars

[variable names follow style guide](https://github.com/ensemble-ai/exercise-2-camera-control-puncakedev/blob/4412ab6f1c9689d4e570302724f4a58dbe379a55/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L34)
[variables are explicitly typed](https://github.com/ensemble-ai/exercise-2-camera-control-puncakedev/blob/4412ab6f1c9689d4e570302724f4a58dbe379a55/Obscura/scripts/camera_controllers/four_way.gd#L60)

---

---

# Best Practices

A lot of best practices have been followed, could not find any infractions within the camera controller scripts.

#### Best Practices Infractions

#### Best Practices Exemplars

[the only line that exceeds 100 characters is the one that is copied from pushbox.gd](https://github.com/ensemble-ai/exercise-2-camera-control-puncakedev/blob/4412ab6f1c9689d4e570302724f4a58dbe379a55/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L71)
[separates the functions by two lines](https://github.com/ensemble-ai/exercise-2-camera-control-puncakedev/blob/4412ab6f1c9689d4e570302724f4a58dbe379a55/Obscura/scripts/camera_controllers/four_way.gd#L17)
