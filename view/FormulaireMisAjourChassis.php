<section class="FormulaireMisAjourChassis" data-component="FormulaireMisAjourChassis" data-js-component="Form">

	
	<?php

	if($data["chassis"]){
		foreach ($data["chassis"] as $Chassis) {
			$idCh =  $Chassis["idChassis"];
			$chassis =  $Chassis["chassisfr"];
		}
	}

		
?>




	<form>
		<h1>Mettre à jour chassis</h1>
		<div class="input-wrapper" data-js-input-wrapper>
			<div class="ligne distribue">
				<label for="idChassis">ID :</label>
				<input type="text" id="idChassis" required data-js-param="idChassis" disabled value=<?php echo '"'.$idCh.'"' ?>>
			</div>


		<div class="input-wrapper" data-js-input-wrapper>
			<div class="ligne distribue">
				<label for="chassis">Chassis :</label>
				<input type="text" id="chassis" required data-js-param="chassis" value=<?php echo '"'.$chassis.'"' ?>>
			</div>
			
			
			<small class="error-message" data-js-error-msg></small>
		</div> 


		<button data-js-btnMAJ>Soumettre</button>
	</form>
</section>

