<?php

// IMPORTANT VOUS DEVEZ CONFIGURER
// L'ADRESSE EMAIL DE DESTINATION
$dest="arabine@programmationworld.com";

// on recupere les infos
$referer= getenv("HTTP_REFERER");

// validation de forme 
//
// ici inserer si besoin
// les tests de validites
// (syntaxe, champ obligatoire)
// des champs de la forme
// ...
// mettre $ok a faux si c'est un echec
if ($nom=="" || $prenom=="" || $email=="" || $rue=="" || $codepostal=="" || $ville=="" || $pack=="")
{
	$ok=0;
}
else
{
	$ok=1;
}

if($ok){


 // envoi des resultats par email
 
 
 $sujet= "Commande UIR";
 $body="Page d'origine : $referer\n";
 $body.="\n*** Valeurs resultats ***\n";
 
 if(count($HTTP_POST_VARS)){
    while (list($key, $val) = each($HTTP_POST_VARS)){
       $body.="$key : $val\n";
    }  
 }

 if(count($HTTP_GET_VARS)){
    while (list($key, $val) = each($HTTP_GET_VARS)){
      $body.="$key : $val\n";
    }  
 }

 // Envoie de la commande
	$body.="*************************\n";
	mail($dest,$sujet,$body);

// Envoie du reçu au client
   $sujet= "Reçu de votre commande";
   $body.="Voici les informations que vous avez entrées.\n";
   $body.="Si elles contiennent des erreurs, mailez moi ici : arabine@programmationworld.com\n";
   $body.="*************************\n";
   $body.="http://www.programmationworld.com\n";
   mail($email,$sujet,$body);

 
// affiche le html qui suit si succes
?>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta name="author" content="Anthony Rabine">
	<title>Succès</title>
    <link title="Style"        href="../../belegar.css"
                               type="text/css" rel="stylesheet">
  </head>
  <body bgcolor="#ffffff">
    <table class="main" width="99%">
      <tr>
        <td class="titleprincipal"><a name="Top">
          Commande envoyée
          </a>
        </td>
      </tr>
      <tr>
        <td>
          <br><br><br><br>
        </td>
      </tr>
      <tr>
        <td>
          <p><div align="center">
		  <font size="4">Votre formulaire est envoyé. Pour suivre l'avancée de votre commande, renseignez-vous en 
		  envoyant un mail à l'adresse ci-dessous, sans oublier de spécifier votre nom :<br><br>
		  <a href="mailto:arabine@programmationworld.com?subject=Progworld : Commande UIR">arabine@programmationworld.com</a>
		  <br><br>
		  Toute l'équipe de programmationworld vous remercie !<br><br>
		  
		  <a href="index.htm">Retour à l'index</a>
		  </font></div>
          </p>
        </td>
      </tr>
      <tr>
        <td>
          <br><br>
        </td>
      </tr>
      <tr>
        <td align="center">
          <font color="#9999FF" size="-3">
            <br><br>
            par&nbsp;Anthony Rabine<br>
            Derni&egrave;re mise &agrave; jour:
            <script language="javascript">
              document.writeln(document.lastModified.substring(0, 10))
            </script>
          </font>
        </td>
      </tr>
    </table>
  </body>
</html>
<?php
}

// affiche le html qui suit si erreur
// 
else{
?>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta name="author" content="Anthony Rabine">
    <title>Erreur</title>
    <link title="Style"        href="../../belegar.css"
                               type="text/css" rel="stylesheet">
  </head>
  <body bgcolor="#ffffff">
    <table class="main" width="99%">
      <tr>
        <td class="titleprincipal"><a name="Top">
          Erreur !
          </a>
        </td>
      </tr>
      <tr>
        <td>
          <br><br><br><br>
        </td>
      </tr>
      <tr>
        <td>
          <p><div align="center">
		  <font size="4">Une erreur est survenue. Vérifiez la validité de tous les champs et recommencez l'opération en 
		  cliquant sur le bouton "back" de votre navigateur. En cas d'échecs répétés, envoyez moi la commande par 
		  mail à l'adresse ci-dessous en prenant soin de fournir tous les renseignements.<br><br>
		  <a href="mailto:arabine@programmationworld.com?subject=Progworld : Commande UIR">arabine@programmationworld.com</a>
		  <br><br>
		  Merci !
		  </font></div>
          </p>
        </td>
      </tr>
      <tr>
        <td>
          <br><br>
        </td>
      </tr>
      <tr>
        <td align="center">
          <font color="#9999FF" size="-3">
            <br><br>
            par&nbsp;Anthony Rabine<br>
            Derni&egrave;re mise &agrave; jour:
            <script language="javascript">
              document.writeln(document.lastModified.substring(0, 10))
            </script>
          </font>
        </td>
      </tr>
    </table>
  </body>
</html>
<?php
}
?>
