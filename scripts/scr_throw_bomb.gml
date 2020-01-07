/*
Lancé de bombe dans la direction du regard (image_xscale)

*/


bomb = instance_create(x,y - sprite_height/2 - sprite_get_height(spr_bombe)/2, obj_bombe_libre);
if x < room_width/2 {
    bomb.thrown = 'right';
}
else {
    bomb.thrown = 'left';
}
sprite_index = spr_idle;
hold_bomb = false;
ennemi.hold_bomb = false;
