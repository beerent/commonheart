import Phaser from 'phaser'

import HelloWorldScene from './scenes/HelloWorldScene'

const config: Phaser.Types.Core.GameConfig = {
	type: Phaser.AUTO,
	width: 480,
	height: 270,
	physics: {
		default: 'arcade',
		arcade: {
			gravity: { y: 20000 },
		},
	},
	scene: [HelloWorldScene],
	scale: {
		zoom: 3.6
	}
}

export default new Phaser.Game(config)
