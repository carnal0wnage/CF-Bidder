��/ * * * * * *   O b j e c t :     T a b l e   [ B i d d e r ]         S c r i p t   D a t e :   0 2 / 0 7 / 2 0 1 1   0 9 : 1 1 : 4 1   * * * * * * /  
  
 C R E A T E   T A B L E   [ B i d d e r ] (  
 	 [ u s e r n a m e ]   [ v a r c h a r ] ( 5 0 )   N O T   N U L L ,  
 	 [ p a s s w o r d ]   [ v a r c h a r ] ( 5 0 )   N O T   N U L L ,  
 	 [ f u l l n a m e ]   [ v a r c h a r ] ( 2 5 0 )   N U L L ,  
 	 [ a d d r e s s ]   [ v a r c h a r ] ( 2 5 0 )   N U L L ,  
 	 [ c i t y ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ s t a t e ]   [ v a r c h a r ] ( 2 )   N U L L ,  
 	 [ z i p ]   [ v a r c h a r ] ( 5 )   N U L L ,  
 	 [ p h o n e ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ e m a i l ]   [ v a r c h a r ] ( 2 5 0 )   N U L L ,  
   C O N S T R A I N T   [ P K _ B i d d e r ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ u s e r n a m e ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N ,   F I L L F A C T O R   =   9 0 )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ I t e m ]         S c r i p t   D a t e :   0 2 / 0 7 / 2 0 1 1   0 9 : 1 1 : 4 1   * * * * * * /  
  
 C R E A T E   T A B L E   [ I t e m ] (  
 	 [ i d ]   [ i n t ]   N O T   N U L L ,  
 	 [ c a t e g o r y _ i d ]   [ i n t ]   N U L L ,  
 	 [ n a m e ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ d e s c r i p t i o n ]   [ v a r c h a r ] ( m a x )   N U L L ,  
 	 [ p h o t o _ f i l e ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ b i d _ a m o u n t ]   [ i n t ]   N O T   N U L L ,  
     	 [ m i n i m u m _ b i d ]   [ i n t ]   N O T   N U L L   ,  
 	 [ b i d d e r _ i d ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ s t a t u s ]   [ b i t ]   N O T   N U L L ,  
 	 [ m a x i m u m _ b i d ]   [ i n t ]   N U L L ,  
 	 [ c l o s e _ t i m e ]   [ d a t e t i m e ]   N U L L ,  
 	 [ s u b m i t t e r _ n a m e ]   [ v a r c h a r ] ( 2 5 0 )   N U L L ,  
 	 [ s u b m i t t e r _ p h o n e ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ d a t e _ p a i d ]   [ d a t e t i m e ]   N U L L ,  
 	 [ c h e c k n o ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ c a s h ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
   C O N S T R A I N T   [ P K _ I t e m ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ i d ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N ,   F I L L F A C T O R   =   9 0 )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ M a s t e r ]         S c r i p t   D a t e :   0 2 / 0 7 / 2 0 1 1   0 9 : 1 1 : 4 1   * * * * * * /  
  
 C R E A T E   T A B L E   [ M a s t e r ] (  
 	 [ m s t _ n o ]   [ i n t ]   N O T   N U L L ,  
 	 [ m s t _ p a s s w o r d ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ m s t _ s t a t u s ]   [ b i t ]   N O T   N U L L ,  
 	 [ m s t _ c l o s e _ t i m e ]   [ d a t e t i m e ]   N U L L ,  
 	 [ m s t _ o p e n _ t i m e ]   [ d a t e t i m e ]   N U L L  
   C O N S T R A I N T   [ P K _ M a s t e r ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ m s t _ n o ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N ,   F I L L F A C T O R   =   9 0 )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ C a t e g o r y ]         S c r i p t   D a t e :   0 2 / 0 7 / 2 0 1 1   0 9 : 1 1 : 4 1   * * * * * * /  
  
 C R E A T E   T A B L E   [ C a t e g o r y ] (  
 	 [ i d ]   [ i n t ]   I D E N T I T Y ( 1 , 1 )   N O T   N U L L ,  
 	 [ n a m e ]   [ v a r c h a r ] ( 5 0 )   N U L L  
 )   O N   [ P R I M A R Y ]  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ L o g ]         S c r i p t   D a t e :   0 2 / 0 7 / 2 0 1 1   0 9 : 1 1 : 4 1   * * * * * * /  
  
 C R E A T E   T A B L E   [ L o g ] (  
 	 [ i d ]   [ i n t ]   I D E N T I T Y ( 1 , 1 )   N O T   N U L L ,  
 	 [ i t e m _ i d ]   [ i n t ]   N O T   N U L L ,  
 	 [ b i d _ a m o u n t ]   [ i n t ]   N O T   N U L L ,  
 	 [ b i d d e r _ i d ]   [ v a r c h a r ] ( 5 0 )   N O T   N U L L ,  
 	 [ b i d _ d a t e ]   [ d a t e t i m e ]   N O T   N U L L  
   C O N S T R A I N T   [ P K _ L o g ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ i d ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N ,   F I L L F A C T O R   =   9 0 )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]  
 G O  
  
 / * * * * * *   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
   I n s e r t   d e f a u l t   r e c o r d s  
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   * * * * * * /  
 I N S E R T   I N T O   M a s t e r   ( m s t _ n o , m s t _ p a s s w o r d , m s t _ s t a t u s , m s t _ c l o s e _ t i m e , m s t _ o p e n _ t i m e )   V A L U E S   ( 1 , ' bid ' , 0 , N U L L , N U L L ) ;  
 I N S E R T   I N T O   C a t e g o r y   ( n a m e )   V A L U E S   ( ' C l o t h i n g ' ) ;  
 I N S E R T   I N T O   C a t e g o r y   ( n a m e )   V A L U E S   ( ' E n t e r t a i n m e n t ' ) ;  
 I N S E R T   I N T O   C a t e g o r y   ( n a m e )   V A L U E S   ( ' G i f t   C a r d s / C e r t i f i c a t e s ' ) ;  
 I N S E R T   I N T O   C a t e g o r y   ( n a m e )   V A L U E S   ( ' H o u s e h o l d ' ) ;  
 I N S E R T   I N T O   C a t e g o r y   ( n a m e )   V A L U E S   ( ' M i s c e l l a n e o u s ' ) ;  
 I N S E R T   I N T O   C a t e g o r y   ( n a m e )   V A L U E S   ( ' S e r v i c e s ' ) ;  
 I N S E R T   I N T O   C a t e g o r y   ( n a m e )   V A L U E S   ( ' S p o r t s ' ) ;  
 