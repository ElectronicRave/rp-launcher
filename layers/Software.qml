import QtQuick 2.12


	Item {
		id: software

	//Back to Home

	Keys.onPressed: {
		if (api.keys.isCancel(event)) {
		event.accepted = true
		api.memory.unset('currentCollectionIndex', currentCollectionIndex)
		searchValue=''
		header__search_input.text=''
		navigate('Home')
		return
	}

}

	Rectangle {
		id: header
		color: "transparent"
		width: headerCSS.width
		height: header_inner.height+header__border.height + aspectRatio === 43 ? vpx(70*screenRatio) : vpx(60*screenRatio)
		clip: true

	anchors {
		top: parent.top;
	}

	Rectangle {
		id: header_inner
		color: "transparent"
		width: parent.width
		height: parent.height

	//Search games and softwares

	Rectangle {
		id: header__search
		color: theme.background
		width: aspectRatio === 43 ? vpx(100*screenRatio) : vpx(100*screenRatio)
		height: aspectRatio === 43 ? vpx(28*screenRatio) : vpx(26*screenRatio)
		border.color: theme.text
		border.width: aspectRatio === 43 ? vpx(2*screenRatio) : vpx(1*screenRatio)
		radius: 100
		visible: searchValue

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? vpx(32*screenRatio) : vpx(24*screenRatio)
		right: parent.right; rightMargin: aspectRatio === 43 ? vpx(140*screenRatio) : vpx(165*screenRatio)
	}

	TextInput {
		property var marginRight: aspectRatio === 43 ? vpx(23*screenRatio) : vpx(22*screenRatio)

		id: header__search_input
		clip: true
		width: parent.width - marginRight
		height: parent.height
		color: theme.text
		font.pixelSize: aspectRatio === 43 ? vpx(16*screenRatio) : vpx(15*screenRatio)

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? vpx(24*screenRatio) : vpx(22*screenRatio)
		left: parent.left; leftMargin: aspectRatio === 43 ? vpx(13*screenRatio) : vpx(12*screenRatio)
		verticalCenter: parent.verticalCenter
	}

	onTextEdited: {
		gameView.currentIndex = 0
		searchValue = header__search_input.text
		gameView.model = searchGames
	}

	Keys.onPressed: {
		if (api.keys.isAccept(event)) {
		navigate('Software')
		return
	}  
		if (event.key == Qt.Key_Down) {
		navigate('Software')
		return
	}

}

}
 
}

}

	Rectangle {
		id: header__border
		width: parent.width
		height: aspectRatio === 43 ? vpx(0*screenRatio) : vpx(0*screenRatio)
		color: "transparent"

	anchors {
		top: header_inner.bottom; topMargin: aspectRatio === 43 ? vpx(4*screenRatio) : vpx(4*screenRatio)
		left: parent.left; leftMargin: aspectRatio === 43 ? vpx(10*screenRatio) : vpx(10*screenRatio)
	}

}

}

	Rectangle {
		id: main
		color: "transparent"
		width: wrapperCSS.width
		height: mainCSS.height

	anchors {
		top: header.bottom
	}

	Rectangle {
		id: game
		visible: true
		clip: true
		color: "transparent"
		width: parent.width
		height: parent.height

	anchors {
		left: parent.left
		right: parent.right
		top: parent.top
		bottom: parent.bottom
	}

	GridView {
		id: gameView
		cellWidth: width / numcolumns
		cellHeight: cellWidth
		model: currentCollection.games
		snapMode: ListView.SnapOneItem
		delegate: gameViewDelegate
		focus: currentPage === 'Software' ? true : false
		clip: true

		highlightRangeMode: ListView.StrictlyEnforceRange
		preferredHighlightBegin: aspectRatio === 43 ? vpx(1*screenRatio) : vpx(1*screenRatio)
		preferredHighlightEnd: aspectRatio === 43 ? vpx(0*screenRatio) : vpx(0*screenRatio)

	anchors {
		left: parent.left; leftMargin: aspectRatio === 43 ? vpx(75*screenRatio) : vpx(70*screenRatio)
		top: parent.top; topMargin: aspectRatio === 43 ? vpx(38*screenRatio) : vpx(13*screenRatio)
		right: parent.right; rightMargin: aspectRatio === 43 ? vpx(65*screenRatio) : vpx(60*screenRatio)
		bottom: parent.bottom; bottomMargin: aspectRatio === 43 ? vpx(-6*screenRatio) : vpx(-6*screenRatio)
	}

		Keys.onUpPressed:       { moveCurrentIndexUp() }
		Keys.onDownPressed:     { moveCurrentIndexDown() }
		Keys.onLeftPressed:     { moveCurrentIndexLeft() }
		Keys.onRightPressed:    { moveCurrentIndexRight() }

	Component {
		id: gameViewDelegate

	Item {
		id: game__item_container
		property bool selected: GridView.isCurrentItem
		width: gameView.cellWidth - vpx(10*screenRatio)
		height: width

	//Launch game

	Keys.onPressed: {
		if (api.keys.isAccept(event)) {
		event.accepted = true
		currentGameIndex = index
		currentGame.launch()
		return
}

	//We reset collection when going home

	if (api.keys.isCancel(event)) {
	api.memory.unset('currentCollectionIndex', currentCollectionIndex)
	return
}

	//Next collection

	if (api.keys.isNextPage(event)) {
	event.accepted = true
	currentCollectionIndex = currentCollectionIndex+1
	return
}

	//Prev collection

	if (api.keys.isPrevPage(event)) {
	event.accepted = true
	currentCollectionIndex = currentCollectionIndex-1
	return
}

}

	Rectangle {
		id: game__item
		width: parent.width
		height: parent.height
		color: theme.buttons
}

	Image {
		id: game__screenshot
		width: parent.width
		height: parent.height
		fillMode: Image.PreserveAspect
		source: modelData.assets.screenshots[0]
		asynchronous: true
		smooth: true
		z: 1

	anchors {
		fill: parent
	}

}

	Image {
		id: game__logo
		width: parent.width
		height: parent.height
		source: modelData.assets.boxFront ? modelData.assets.boxFront : modelData.assets.logo
		fillMode: Image.PreserveAspect
		asynchronous: true
		smooth: true

	anchors {
		fill: parent
		margins: aspectRatio === 43 ? vpx(28*screenRatio) : vpx(21*screenRatio)
	}

}
 
	MouseArea {
		anchors.fill: game__screenshot && game__logo
		onClicked: {
			if (selected) {
				currentGameIndex = index
				currentGame.launch()
	}
			else
				gameView.currentIndex = index
	}
		onPressAndHold: {
			currentGameIndex = index
			currentGame.favorite = !currentGame.favorite
	}

}

	Rectangle {
		id: game__item_border
		width: parent.width
		height: parent.height
		color: "transparent"
		border.color: theme.accent
		border.width: aspectRatio === 43 ? vpx(3*screenRatio) : vpx(3*screenRatio)
		opacity: selected ? 1 : 0
		z: 7

	anchors {
		centerIn: game__screenshot && game__logo
	}

}

	//Favorite

	Canvas {
		id: game__favorite
		visible: modelData.favorite && currentCollection.shortName !== "all-favorites"
		z: 1

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? vpx(4*screenRatio) : vpx(4*screenRatio)
		right: parent.right; rightMargin: aspectRatio === 43 ? vpx(5*screenRatio) : vpx(5*screenRatio)
	}

	Image {
		width: aspectRatio === 43 ? vpx(28*screenRatio) : vpx(22*screenRatio)
		fillMode: Image.PreserveAspectFit
		source: focus ? "../assets/icons/favorite.png" : "../assets/icons/favorite.png"
		asynchronous: true
		smooth: true

	anchors {
		right: parent.right; rightMargin: aspectRatio === 43 ? vpx(4*screenRatio) : vpx(4*screenRatio)
		top: parent.top; topMargin: aspectRatio === 43 ? vpx(4*screenRatio) : vpx(4*screenRatio)
	}

}

}

	Rectangle {
		id: game__title
		color: "#2C2C2C"
		width: parent.width
		height: aspectRatio === 43 ? vpx(26*screenRatio) : vpx(20*screenRatio)
		opacity: 0.8
		z: 1

	anchors {
		bottom: parent.bottom
		left: parent.left
		right: parent.right
		horizontalCenter: parent.horizontalCenter
	}

	Text {
		id: game__title_name
		text: modelData.title
		color: "#FFFFFF"
		font.family: titleFont.name
		font.bold: true
		font.pixelSize: aspectRatio === 43 ? vpx(16*screenRatio) : vpx(12*screenRatio)
		elide: Text.ElideRight
		horizontalAlignment: Text.AlignHCenter

	anchors { 
		bottom: parent.bottom; bottomMargin: aspectRatio === 43 ? vpx(5*screenRatio) : vpx(4*screenRatio)
		left: parent.left
		right: parent.right
	}

}

}

}

}

}

}
       
}

	Header {}

	Footer {}

}