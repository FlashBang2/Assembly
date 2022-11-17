this.hook_cooldown=1
                  kier="GÓRA";
                  var zw=0 ;
                  n=0;
                  troz=this.scene.time.addEvent({ delay: 170, callback: ()=>
                  {
                  if (n<19)
                     {
                        lancuch=this.scene.physics.add.sprite(this.x,(this.y-35)-32*n, 'lancuch',  3).play({ key: 'lancuch', repeat: 0 }).setDepth(10000);
                        lancuch.rotation=Phaser.Math.DegToRad(0)
                        lancuchg.add(lancuch);
                     if (this.scene.layer2!=undefined && this.scene.layer4!=undefined)
                        {
                        if (this.scene.layer2.getTileAtWorldXY(this.x,(this.y-35)-32*(n+1))||this.scene.layer4.getTileAtWorldXY(this.x,(this.y-35)-32*(n+1)))
                           {
                           if(this.scene.layer2.getTileAtWorldXY(this.x,(this.y-35)-32*(n+1))||this.scene.layer4.getTileAtWorldXY(this.x,(this.y-35)-32*(n+1)).properties.collide==true)
                              {
                                 hak=this.scene.physics.add.sprite(this.x,(this.y-35)-32*n, 'lancuch',  3,{angle: 0}).play({ key: 'lancuch_head', repeat: 0 }).setDepth(10000);
                                 lancuchg.add(hak);
                                 zw=1;
                                 this.scene.time.removeEvent(troz);
                              }
                           }
                        }
                     }
                     else 
                        {
                           hak=this.scene.physics.add.sprite(this.x,(this.y-35)-32*n, 'lancuch',  3,{angle: 0}).play({ key: 'lancuch_head', repeat: 0 }).setDepth(10000);
                           lancuchg.add(hak);
                           zw=1;
                        }
                               n++;
                  }, callbackScope: this ,
                             repeat: 19,
                           });
                           tz1=this.scene.time.addEvent({ delay:195, callback: ()=>
                              {
                              if(zw==1)
                                 {
                                 if(lancuchg.countActive()<=0)
                                    {
                                       this.hook_cooldown=0;
                                       this.scene.time.removeEvent(tz1);
                                       this.scene.time.removeEvent(tz2);
                                    }
                                 else
                                   {
                                       var lo=lancuchg.getFirst(true)
                                       lo.rotation=Phaser.Math.DegToRad(180)
                                       lo.play({ key: 'lancuchr', repeat: 0 })
                                       this.scene.time.delayedCall(100, ()=>
                                       {
                                       if (lancuchg.countActive()>0)
                                          {
                                               lancuchg.shiftPosition(0, -32, 1);
                                               kier="";
                                          }
                                          else
                                          {
                                             this.hook_cooldown=0;
                                             this.scene.time.removeEvent(tz1);
                                             this.scene.time.removeEvent(tz2);
                                          }
                                          lo.destroy(); 
                                       });
                                   }
                                 }
                              }, callbackScope: this ,
                              loop: true,
                              }); 
                              tz2=this.scene.time.addEvent({ delay:5, callback: ()=>
                                 {
                                 if(lancuchg.countActive()>0)
                                   {
                                       n1=0
                                       lancuchg.getChildren().forEach((lancuch)=>
                                       {
                                          lancuch.setPosition(this.x,(this.y-35)-32*n1);
                                       if (this.scene.layer2!=undefined && this.scene.layer4!=undefined)
                                          {
                                             this.scene.physics.add.collider(this.scene.layer2,lancuch,()=>
                                             {
                                                kier="";
                                                zw=1;
                                                this.scene.time.removeEvent(troz);
                                             });
                                          }
                                          n1++;
                                       });
                                   }   
                                 }, callbackScope: this ,
                                 loop: true,
                                 }); 