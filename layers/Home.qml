import QtQuick 2.12


	Item {
		id: home

	Rectangle {
		id: main
		color: "transparent"
		width: wrapperCSS.width
		height: mainCSS.height+115

	anchors {
		top: header.bottom
	}

	Rectangle {
		id: system
		color: "transparent"
		height: main.height-options.height-anchors.topMargin

	anchors {
		left: parent.left; leftMargin: aspectRatio === 43 ? 12: 64
		right: parent.right
		top: parent.top; topMargin: headerHeightCorrection === 0 ? 0 : 24
	}

	ListView {
		id: systemListView
		model: api.collections
		snapMode: ListView.SnapOneItem
		delegate: systemDelegate
		orientation: ListView.Horizontal
		focus: currentPage === 'Home' ? true : false
		spacing: 22

		highlightRangeMode: ListView.StrictlyEnforceRange
		preferredHighlightBegin: 230
		preferredHighlightEnd: 1560
		highlightMoveDuration: 200
		highlightMoveVelocity: -1

	anchors {
		left: parent.left
		right: parent.right
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : 270
		bottom: parent.bottom
	}

		Keys.onLeftPressed: { decrementCurrentIndex() } 
		Keys.onRightPressed: { incrementCurrentIndex() }

	Component {
		id: systemDelegate
                  
	Item {
		id: system__item_container
		property bool selected: ListView.isCurrentItem
		width: 380
		height: width

	//Browse the collection and return to the same place after playing

	Keys.onPressed: {
		if (api.keys.isAccept(event)) {
		event.accepted = true;
		currentCollectionIndex = system__item_container.ListView.view.currentIndex+3;
		api.memory.set('currentCollectionIndex', currentCollectionIndex);
		navigate('Software');
		return
	}

}

	Text {
		id: system__item_title
		text: modelData.name
		color: theme.accent
		font.pixelSize: vpx(18*screenRatio)
		font.bold: true
		height: vpx(32*screenRatio)
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideRight
		opacity: selected ? 1 : 0

	anchors {
		horizontalCenter: system__item_container.horizontalCenter
	}

}

	Rectangle {
		id: system__item
		width: parent.width
		height: parent.height
		color: theme.buttons

	anchors {
		top : system__item_title.bottom
	}
  


	Image {
		id: system__logo
		height: parent.height
		width: parent.width
		fillMode: Image.PreserveAspect
		source: "../assets/images/logos/"+modelData.shortName+".jpg"
		asynchronous: true
		smooth: true

	anchors {
		fill: parent
	}

}

	MouseArea {
		anchors.fill: system__logo
		onClicked: {
			if (selected) {
				currentCollectionIndex = system__item_container.ListView.view.currentIndex+3;
				api.memory.set('currentCollectionIndex', currentCollectionIndex);
				navigate('Software');
				return
	}
			else
				systemListView.currentIndex = index
	}

}

	Rectangle {
		id: system__item_border
		width: parent.width
		height: parent.height
		color: "transparent"
		border.color: theme.accent
		border.width: 10
		opacity: selected ? 1 : 0

	anchors {
		centerIn: system__logo
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