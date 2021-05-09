React - JavaScript Library
==========================

Some initial notes during the exploration of [React.js](https://reactjs.org/) JavaScript library.

## Draft
Everything on this page is in draft-mode. Expect errors, amendments, oversights, and corrections.

### Quick Start
- Facebook's [create-react-app](https://github.com/facebook/create-react-app)
- [MDN web docs - JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- Compatibility checks with browser via [Babel](https://babeljs.io/)
- Reusable components! [bit](https://github.com/teambit/bit)

### CONTENTdm Documentation
CONTENTdm provides [JavaScript Customization Docs](https://help.oclc.org/Metadata_Services/CONTENTdm/Advanced_website_customization/JavaScript_customizations) to facilitate a general understanding of the React-based CONTENTdm application.

#### [CSS Classes](https://help.oclc.org/Metadata_Services/CONTENTdm/Advanced_website_customization/CSS_customizations/CSS_page_classes)

CSS Classes are broken down into the following classifications:
> Website-level classes
Component-level classes
Page: Global classes
Page: Collection-level classes

#### [JavaScript Events](https://help.oclc.org/Metadata_Services/CONTENTdm/Advanced_website_customization/JavaScript_customizations/JavaScript_events)
A special event fires at the initial load of the application: `cdm-app:ready`. This event fires once for a given end-user session and is the earliest time point in the application lifecycle.

> :enter  
:ready  
:update  
:leave


In CONTENTdm, __if the URL does not change__, then the end user action is most likely happening simultaneously with an `:update` event.

#### [List of Lifecycle Events](https://help.oclc.org/Metadata_Services/CONTENTdm/Advanced_website_customization/JavaScript_customizations/List_of_JavaScript_lifecycle_events)

The CONTENTdm application provides a CustomEvent() object within the lifecycle of the application and page render

```bash
document.addEventListener('cdm-home-page:enter', function(e){
    // e is instance of CustomEvent
    // ...
});
```
#### [Customization Cookbook](https://help.oclc.org/Metadata_Services/CONTENTdm/Advanced_website_customization/Customization_cookbook)

There's also a [Recipe Portal](https://cdmdemo.contentdm.oclc.org/digital/custom/recipedownloads) with downloadable code and demonstration sites.
