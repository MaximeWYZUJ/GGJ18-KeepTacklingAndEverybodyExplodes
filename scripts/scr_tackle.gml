/*
Procédure dans l'event Collision avec l'ennemi

*/


if buffer_tackle == true { // Si on tente un tacle
    if ennemi.buffer_tackle == false { //le joueur adverse ne tente pas de tacle
        ennemi.stun = true;
        ennemi.sprite_index = ennemi.spr_stun;
        ennemi.alarm[0] = 180;
        if ennemi.hold_bomb == true {
            points += 10;
        }
        if ennemi.hold_bomb == true {
            scr_throw_bomb();
        }
        if !audio_is_playing(snd_tacle) {
            audio_play_sound(snd_tacle, 1, false);
        }
        ennemi.alarm[2] = 45; // déclenchement du son d'étourdissement
        
    } else { // les deux joueurs se taclent
        ennemi.stun = true;
        stun = true;
        ennemi.sprite_index = ennemi.spr_stun;
        sprite_index = spr_stun;
        ennemi.alarm[0] = 180;
        alarm[0] = 180;
        // impossible de tacler en ayant la bombe
        hspeed = - hspeed//sign(hspeed) * impulsion_tackle;
        ennemi.hspeed = sign(ennemi.hspeed) * impulsion_tackle;
    }
}
