<template>
	<div class="d-flex flex-column gap-3 h-75">
		<input type="text" v-model="title" placeholder="Название фильма" class="form-control title-input">

		<input type="number" placeholder="Оценка" class="form-control rate-input" v-model="rate" min="0" max="10" step="1">

		<textarea class="form-control note-input" placeholder="Заметка" v-model="note"></textarea>
		
		<select class="form-select" v-model="author_id">
			<option v-for="author in authors" :key="author.id" :value="author.id">{{ author.name }}</option>
		</select>


		<div class="d-flex flex-row flex-wrap gap-3">
			<div v-for="tag in tags" :key="tag.id" class="form-check">
				<input :value="tag" v-model="selected_tags" v-bind:id="'tag_' + tag.id" class="form-check-input" type="checkbox">
				<label class="form-check-label" v-bind:for="'tag_' + tag.id">{{ tag.name }}</label>
			</div>
		</div>

		<div class="d-flex flex-row flex-wrap gap-3">
			<div class="form-check">
				<input value="planned" v-model="status" class="form-check-input" type="radio" name="flexRadioDefault" id="planned">
				<label class="form-check-label" for="planned">
					planned
				</label>
			</div>
			<div class="form-check">
				<input value="watched" v-model="status" class="form-check-input" type="radio" name="flexRadioDefault" id="watched">
				<label class="form-check-label" for="watched">
					watched
				</label>
			</div>
			<div class="form-check">
				<input value="dropped" v-model="status" class="form-check-input" type="radio" name="flexRadioDefault" id="dropped">
				<label class="form-check-label" for="dropped">
					dropped
				</label>
			</div>
		</div>

		
		<button type="button" class="btn btn-success" @click="saveFilm">
			Сохранить фильм
		</button>

		<ul>
			<li v-for="film in films">
				{{ film }}
			</li>
		</ul>
		

	</div>
</template>
	
<script setup>
    import { ref, onMounted } from 'vue';

	const authors = ref([])
	const tags = ref([]) 

	const film_id = ref(0)
	const title = ref('')
	const rate = ref(0)
	const note = ref('')
	const author_id = ref(0)
	const selected_tags = ref([])
	const status = ref('')

	const films = ref([])

	



    onMounted(async() => {
        const fethed_authors = await fetch("http://localhost:3000/authors")
        authors.value = await fethed_authors.json()

		const fethed_tags = await fetch("http://localhost:3000/tags")
        tags.value = await fethed_tags.json()

		const fethed_films = await fetch("http://localhost:3000/films")
        films.value = await fethed_films.json()

    })



	// const add_tag = (tag) => {
	// 	selected_tags.value.push(tag)
	// }


    const saveFilm = async() => {
        const res = await fetch("http://localhost:3000/films", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                title: title.value,
				rate: rate.value,
				note: note.value,
				author_id: author_id.value,
				tags: selected_tags.value,
				status: status.value
            })
        })

        const data = await res.json()

        films.value.push(data)

		film_id.value = 0;
        title.value = ''
		rate.value = 0
		note.value = ''
		author_id.value = 0
		selected_tags.value = []
		status.value = ''
    }

    // const updateAuthor = async() => {
    //     const res = await fetch (`${API_URL}/${author_id.value}`, {
    //         method: 'PUT',
    //         headers: {
    //             'Content-Type': 'application/json'
    //         },
    //         body: JSON.stringify({
    //             name: name.value,
    //             id: author_id.value
    //         })
    //     })

    //     const data = await res.json()

    //     const index = authors.value.findIndex(tagauthor => author.id === data.id)
    //     authors.value[index] = data

    //     name.value = ''
    //     author_id.value = 0;
    //     authorIsEditing.value = false
    // }

    // const cancelAuthorEdit = () => {
    //     name.value = ''
    //     author_id.value = 0;
    //     authorIsEditing.value = false
    // }

    // const deleteAuthor = async(id) => {
    //     await fetch (`${API_URL}/${id}`, {
    //         method: 'DELETE'
    //     })
    //     authors.value = authors.value.filter(author => author.id !== id)
    // }

    // const editAuthor = async(id) => {
    //     const author = authors.value.find(author => author.id === id)

    //     name.value = author.name
    //     author_id.value = author.id
    //     authorIsEditing.value = true

    //     window.scrollTo({
    //         top: 0,
    //         behavior: 'smooth'
    //     })
    // }
</script>