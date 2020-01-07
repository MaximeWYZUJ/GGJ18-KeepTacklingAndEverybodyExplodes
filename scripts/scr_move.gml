/*
Procedure qui déplace le perso en fonction des touches (J1 ou J2)

Argument[0] : Axe X
Argument[1] : 
Argument[2] : Saut
Argument[3] : Tackle
Argument[4] : Jet de bombe
Argument[5] : Gamepad slot
*/



// Déplacement latéral
if hold_bomb == false {
    vitesse = 8;
} else {
    vitesse = 6; // le porteur va moins vite mais saut plus haut
}

if stun == false && buffer_tackle == false {    // déplacement classique
    if gamepad_axis_value(argument[5], argument[0]) < 0 {
        hspeed = -vitesse;
        image_xscale = -1;
    } else if gamepad_axis_value(argument[5], argument[0]) {
        hspeed = vitesse;
        image_xscale = 1;
    }
}
if buffer_tackle == true && ennemi.buffer_tackle == true {  // déplacement en glissade, on ne change pas de direction et on freine
    hspeed = hspeed * 0.7;
} else if buffer_tackle == true {
    hspeed = hspeed * 0.93;
} else if gamepad_axis_value(argument[5], argument[0]) == 0 { // arrêt classique avec un peu de friction
    hspeed = hspeed * 0.7;
}
if abs(hspeed) < 0.01 {
    hspeed = 0;
}


// Saut
if hold_bomb == true {
    impulsion =  20;
    coeff_acc = 0.9;
} else {
    impulsion = 13;
    coeff_acc = 0.8;
}

if collision_point(x, y+1, obj_sol, false, true) { //rencontre avec le sol
    vspeed = 0;
    bloc = instance_position(x, y, obj_sol);
    y = bloc.y;
} else if vspeed ==0 {
    vspeed = 0.1;
}


if collision_point(x, y+1, obj_sol, false, true) && gamepad_button_check(argument[5], argument[2]) && stun == false {
    vspeed = -impulsion;
} else {
    if abs(vspeed) < 0.9 && vspeed < 0 {//on arrive au sommet de la parabole
        vspeed = abs(vspeed) //on redescend
    } else if vspeed > 0 {
        vspeed = vspeed * 1.2;  //phase descendante
    } else
        vspeed = vspeed * coeff_acc; //phase ascendante
}


// Tackle
impulsion_tackle = 10;

buffer_tackle = buffer_tackle_anim || buffer_tackle_release;
if buffer_tackle == false && sprite_index == spr_tackle { //plus de glissade
    sprite_index = spr_idle;
    image_index = 0;
}

if gamepad_button_check(argument[5], argument[3]) { // on ne tackle pas forcément l'ennemi parce qu'on ne sait pas s'il est là, c'est géré dans l'event de collision
    if stun == false && buffer_tackle == false && hold_bomb == false {
        hspeed = hspeed + sign(hspeed) * impulsion_tackle;
        sprite_index = spr_tackle;
        image_index = 0;
        buffer_tackle_anim = true;
        buffer_tackle_release = true;
    }
}


if gamepad_button_check_released(argument[5], argument[3]) {
    buffer_tackle_release = false;
}
if sprite_index != spr_tackle {
    buffer_tackle_anim = false;
}

// Throw bomb
if stun == false && buffer_tackle == false && hold_bomb == true{
    if gamepad_button_check(argument[5], argument[4]) {
        scr_throw_bomb();
    }
}
