
Animation
- name:string                   name of the animation
- slug:string                   uniqe name for this animation, used for routing
- secret:string                 the hashed secret that allows editing of this animation

- has_many :frames, class_name: "AnimationFrame"

AnimationFrame
- order:integer                 the order of this frame in the animation
- data:string                   json array with the encoded anim data
- animation:references          the animation that this frame belongs to

Message
- body:text                     text body of the message
- color:string                  color of the indicator of message
- animation:references          animation that this message belongs to