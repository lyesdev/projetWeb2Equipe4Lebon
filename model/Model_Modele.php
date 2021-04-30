<?php
	require_once("TemplateDAO.php");  //Ajouter pour le test de la class
	class Model_Modele extends TemplateDAO {
		
		public function getTable() {
			return "modele";
		}
		
		/* Differentes methodes CRUD modele   */
		
		public function obtenirListeModele() {
			try {
				//$stmt = $this->connexion->query("SELECT idModele, idMarque,modele FROM modele where status=1");
				$stmt = $this->connexion->query("SELECT m.idModele as idModele, m.modele as modele, ma.marque as marque from modele m JOIN marque ma on m.idMarque = ma.idMarque");
				$stmt->execute();
				return $stmt->fetchAll();

			}
			catch(Exception $exc) {
				return 0;
			}
		}

		public function obtenirMarqueModel($idModele){
			try {
				$stmt = $this->connexion->query("SELECT marque, idModele FROM modele 
												INNER JOIN marque ON modele.idMarque = marque.idMarque 
												WHERE idModele = $idModele");
				
				$stmt->execute();
				return $stmt->fetchAll();

			}
			catch(Exception $exc) {
				return 0;
			}
		}





		//Chercher  modèle par idMarque
		public function getListeModeleByMarque($idMarque) {
			try {
							$stmt = $this->connexion->query("SELECT idModele, idMarque,modele FROM modele where status=1  && idMarque='" . $idMarque."'");
							$stmt->execute();
							return $stmt->fetchAll();
							//return 1;
			
			}
						catch(Exception $exc) {
							return 0;
						}
			}

		// Ajouter un modèle dans la BD
		public function ajouteModele($idMarque, $model) {		
			try {
				$stmt = $this->connexion->prepare("INSERT INTO modele (idMarque,modele) VALUES (:idMarque, :model)");
				$stmt->bindParam(":idMarque", $idMarque);
				$stmt->bindParam(":model", $model);
				$stmt->execute();
				return $this->connexion->lastInsertId();
				//return 1;
			}	
			catch(Exception $exc) {
				return 0;
			}
		}


				// Supprimer modele dans la BD
		public function supprimerModele($id) {		
			try {
				//Vérifier si modèle existe dans la table voiture
				$existe = $this->chercherModeledasnVoiture($id) ;         
				if ($existe["cont"]  >= 1 )
				{					
					$stmt = $this->connexion->prepare("UPDATE modele SET status=0 WHERE idModele=".$id);
					$stmt->execute();
				}
				else
				{	
						$stmt = $this->connexion->prepare("DELETE FROM modele WHERE idModele=" . $id);
						$stmt->execute();
				}
				//return $stmt->rowCount();
				return 1;

			}
			catch(Exception $exc) {
				return 0;
			}

		}

		// Modifier un modèle dans la BD
		
		public function modifierModele($idModele,$idMarque,$model) {		
			try {
				$stmt = $this->connexion->prepare("UPDATE modele SET idMarque=:idMarque,modele=:model WHERE idModele=" . $idModele);
				$stmt->bindParam(":idMarque", $idMarque);
				$stmt->bindParam(":model", $model);
				$stmt->execute();

				return 1;
			}	
			catch(Exception $exc) {
				return 0;
			}
		}

				//Chercher  modele dans la table voiture
				public function chercherModeledasnVoiture($idModele) {
					try {
									$stmt = $this->connexion->query("SELECT count(*) cont FROM voiture where idModele='" . $idModele."'");
									$stmt->execute();
									//return 1;
									return $stmt->fetch();
									//return 1; //L'utilisateur existe dans la BD
					
					}
								catch(Exception $exc) {
									return 0;
								}
					}

	}
?>