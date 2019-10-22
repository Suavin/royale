jQuery(document).ready(function(t){t("a.noiseTest").on("click",function(i){i.preventDefault(),t(".noise").toggleClass("active"),t(this).toggleClass("active")})}),function(){var t,i,s,h,r,a=[],n=50;function e(){h.clearRect(0,0,t,i),h.globalCompositeOperation="lighter";for(var s=0;s<a.length;s++)a[s].fade(),a[s].move(),a[s].draw();requestAnimationFrame(e)}function o(){this.s={ttl:15e3,xmax:5,ymax:2,rmax:7,rt:1,xdef:960,ydef:540,xdrift:4,ydrift:4,random:!0,blink:!0},this.reset=function(){this.x=this.s.random?t*Math.random():this.s.xdef,this.y=this.s.random?i*Math.random():this.s.ydef,this.r=(this.s.rmax-1)*Math.random()+1,this.dx=Math.random()*this.s.xmax*(Math.random()<.5?-1:1),this.dy=Math.random()*this.s.ymax*(Math.random()<.5?-1:1),this.hl=this.s.ttl/n*(this.r/this.s.rmax),this.rt=Math.random()*this.hl,this.stop=.2*Math.random()+.4,this.s.rt=Math.random()+1,this.s.xdrift*=Math.random()*(Math.random()<.5?-1:1),this.s.ydrift*=Math.random()*(Math.random()<.5?-1:1)},this.fade=function(){this.rt+=this.s.rt},this.draw=function(){var t,i;this.s.blink&&(this.rt<=0||this.rt>=this.hl)?this.s.rt=-1*this.s.rt:this.rt>=this.hl&&this.reset(),t=1-this.rt/this.hl,h.beginPath(),h.arc(this.x,this.y,this.r,0,2*Math.PI,!0),h.closePath(),i=this.r*t,(r=h.createRadialGradient(this.x,this.y,0,this.x,this.y,i<=0?1:i)).addColorStop(0,"rgba(193,254,254,"+t+")"),r.addColorStop(this.stop,"rgba(193,254,254,"+.2*t+")"),r.addColorStop(1,"rgba(193,254,254,0)"),h.fillStyle=r,h.fill()},this.move=function(){this.x+=this.rt/this.hl*this.dx,this.y+=this.rt/this.hl*this.dy,(this.x>t||this.x<0)&&(this.dx*=-1),(this.y>i||this.y<0)&&(this.dy*=-1)},this.getX=function(){return this.x},this.getY=function(){return this.y}}$.fn.sprites=function(){this.append($('<canvas id="sprites"></canvas>')),function(r){var n=function(){t=r.innerWidth(),i=r.innerHeight(),(s=r.find("#sprites")).attr("width",t).attr("height",i)};n(),$(window).resize(function(){n()}),h=s[0].getContext("2d");for(var d=0;d<100;d++)a[d]=new o,a[d].reset();requestAnimationFrame(e)}(this)}}(),$(".spriteWrap").sprites(),$(document).ready(function(){init()}),$(window).mousemove(function(t){$(".cursor").css({left:t.pageX,top:t.pageY})}),$(".cursor-link").on("mouseenter",function(){$(".cursor").addClass("active")}).on("mouseleave",function(){$(".cursor").removeClass("active")});


var audio_element = document.getElementById("audio");
document.onkeydown = function(event) {
    switch (event.keyCode) {
       case 38:
            event.preventDefault();
            audio_vol = audio_element.volume;
            if (audio_vol!=1) {
              try {
                  audio_element.volume = audio_vol + 0.10;
              }
              catch(err) {
                  audio_element.volume = 1;
              }
              
            }
            
          break;
       case 40:
            event.preventDefault();
            audio_vol = audio_element.volume;
            if (audio_vol!=0) {
              try {
                  audio_element.volume = audio_vol - 0.10;
              }
              catch(err) {
                  audio_element.volume = 0;
              }
              
            }
            
          break;
    }
};


var audio;
var playlist;
var tracks;
var current;

var musicarr = ["http://forum.royaleroleplay.com.br/musicas/celine.mp3"];
shuffle(musicarr);

init();
function init(){
    current = 0;
    audio = $('audio');
    audio[0].volume = .40;
    len = musicarr.length;
    
    run(musicarr[current], audio[0]);
    
    audio[0].addEventListener('ended',function(e){
        current++;
        if(current == len){
            current = 0;
        }
        run(musicarr[current],audio[0]);
    });
}

function run(link, player){
        player.src = link;
        audio[0].load();
        audio[0].play();
        $('#playing').html("<ul><li><a>" + link+ "</a></li></ul>");     
}

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex ;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}